import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

import 'models/app_notification.dart';
import 'notification_constants.dart';

/// Notification वर tap झाल्यावर callback function चा type.
/// UI layer ला navigation handle करण्यासाठी वापरतात.
typedef NotificationTapCallback = void Function(AppNotification notification);

/// Android आणि iOS साठी enterprise-level push notification service.
///
/// ही class खालील कामे करते:
/// - Permission management (Android 13+ आणि iOS)
/// - FCM token lifecycle
/// - Foreground, background, terminated message handling
/// - App open असताना local notification banner दाखवणे
/// - Topic subscribe / unsubscribe
class NotificationService {
  /// Private constructor — बाहेरून direct `NotificationService()` create होऊ शकत नाही.
  /// Singleton pattern साठी वापरले.
  NotificationService._();

  /// App मध्ये NotificationService चा एकच instance (Singleton).
  /// सर्व ठिकाणी `NotificationService.instance` वापरा.
  static final NotificationService instance = NotificationService._();

  /// Firebase Cloud Messaging (FCM) चा main instance.
  /// Remote push messages, token, permissions — हे सर्व याच्याद्वारे.
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  /// Local notifications दाखवण्यासाठी plugin instance.
  /// App foreground मध्ये असताना banner दाखवण्यासाठी वापरतो.
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  /// नवीन notification आल्यावर UI ला कळवण्यासाठी stream controller.
  /// `onNotificationReceived` stream या controller वरून emit होते.
  final StreamController<AppNotification> _receivedController =
      StreamController<AppNotification>.broadcast();

  /// User ने notification tap केल्यावर UI ला कळवण्यासाठी stream controller.
  /// Navigation / deep link या stream वरून handle करता येतो.
  final StreamController<AppNotification> _openedController =
      StreamController<AppNotification>.broadcast();

  /// FCM token refresh झाल्यावर नवीन token emit करण्यासाठी stream controller.
  /// Backend ला updated token पाठवण्यासाठी वापरतात.
  final StreamController<String> _tokenController =
      StreamController<String>.broadcast();

  /// Notification tap झाल्यावर call होणारा optional callback.
  /// `initialize()` मध्ये set केला जातो.
  NotificationTapCallback? _onNotificationTap;

  /// FCM token refresh listener चे subscription.
  /// `dispose()` मध्ये cancel करावे लागते.
  StreamSubscription<String>? _tokenRefreshSubscription;

  /// Service आधीच initialize झाला आहे का ते track करते.
  /// Double initialization टाळण्यासाठी वापरले.
  bool _initialized = false;

  /// नवीन notification आल्यावर listen करण्यासाठी public stream.
  /// UI मध्ये `listen()` करून screen update करता येतो.
  Stream<AppNotification> get onNotificationReceived =>
      _receivedController.stream;

  /// User ने notification tap केल्यावर listen करण्यासाठी public stream.
  /// Deep link / navigation येथे handle करा.
  Stream<AppNotification> get onNotificationOpened => _openedController.stream;

  /// FCM token बदलल्यावर listen करण्यासाठी public stream.
  /// Token backend ला save करण्यासाठी वापरा.
  Stream<String> get onTokenRefresh => _tokenController.stream;

  /// Notification service initialize करते — app start वर एकदाच call करा.
  ///
  /// [onNotificationTap] — notification tap झाल्यावर optional callback.
  ///
  /// Steps:
  /// 1. Local notifications setup
  /// 2. Android channels create
  /// 3. iOS foreground presentation configure
  /// 4. FCM message handlers register
  /// 5. App notification वरून launch झाले का ते check
  /// 6. Token refresh listener start
  Future<void> initialize({NotificationTapCallback? onNotificationTap}) async {
    if (_initialized) {
      return;
    }

    _onNotificationTap = onNotificationTap;

    await _initializeLocalNotifications();
    await _createAndroidChannels();
    await _configureForegroundPresentation();
    await _registerMessageHandlers();
    await _handleLaunchNotification();

    _tokenRefreshSubscription = _messaging.onTokenRefresh.listen((token) {
      if (kDebugMode) {
        debugPrint('[FCM] Token refreshed: $token');
      }
      _tokenController.add(token);
    });

    _initialized = true;

    if (kDebugMode) {
      final token = await getToken();
      debugPrint('[FCM] Current token: $token');
    }
  }

  /// Notification permission user कडun मागते.
  ///
  /// Android 13+: `POST_NOTIFICATIONS` permission.
  /// iOS: alert, badge, sound permissions.
  ///
  /// Returns: `true` = permission granted, `false` = denied.
  Future<bool> requestPermissions() async {
    if (Platform.isAndroid) {
      final status = await Permission.notification.request();
      return status.isGranted;
    }

    final settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    return settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;
  }

  /// सध्याची notification permission status परत करते.
  /// UI वर "granted / denied" दाखवण्यासाठी वापरा.
  Future<NotificationSettings> getPermissionStatus() {
    return _messaging.getNotificationSettings();
  }

  /// Device चा unique FCM token परत करते.
  /// Firebase Console "Send test message" साठी हा token copy करा.
  Future<String?> getToken() => _messaging.getToken();

  /// Device चा FCM token delete करते (logout वेळी वापरतात).
  Future<void> deleteToken() => _messaging.deleteToken();

  /// दिलेल्या topic वर subscribe करते (broadcast messages साठी).
  /// Example: `subscribeToTopic('news')` — सर्व news subscribers ला message जातo.
  Future<void> subscribeToTopic(String topic) =>
      _messaging.subscribeToTopic(topic);

  /// दिलेल्या topic वरून unsubscribe करते.
  Future<void> unsubscribeFromTopic(String topic) =>
      _messaging.unsubscribeFromTopic(topic);

  /// App background / terminated असताना FCM message handle करते.
  ///
  /// [message] — Firebase कडun आलेला RemoteMessage.
  /// Data-only message असेल (notification block नसेल) तर local notification दाखवते.
  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    final appNotification = AppNotification.fromRemoteMessage(message);

    if (message.notification == null && message.data.isNotEmpty) {
      await _showLocalNotification(appNotification);
    }
  }

  /// Test साठी local notification device notification tray वर दाखवते.
  ///
  /// [title] — notification शीर्षक.
  /// [body] — notification मजकूर.
  /// [route] — tap केल्यावर navigate करण्यासाठी optional route.
  Future<void> showTestLocalNotification({
    String title = 'Test Notification',
    String body = 'This is a local notification from Sample App.',
    String? route,
  }) async {
    final notification = AppNotification(
      title: title,
      body: body,
      data: {
        if (route != null) NotificationConstants.dataKeyRoute: route,
        NotificationConstants.dataKeyType: 'test',
      },
      receivedAt: DateTime.now(),
      id: DateTime.now().millisecondsSinceEpoch.toString(),
    );

    _receivedController.add(notification);
    await _showLocalNotification(notification);
  }

  /// Service बंद करते — streams आणि subscriptions cleanup करते.
  /// App close किंवा logout वेळी call करा.
  Future<void> dispose() async {
    await _tokenRefreshSubscription?.cancel();
    await _receivedController.close();
    await _openedController.close();
    await _tokenController.close();
    _initialized = false;
  }

  /// `flutter_local_notifications` plugin initialize करते.
  ///
  /// Android: notification icon set करते.
  /// iOS: permission येथे auto-request करत नाही (requestPermissions() वापरा).
  /// Notification tap callbacks register करते.
  Future<void> _initializeLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings(
      NotificationConstants.androidNotificationIcon,
    );

    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: _onLocalNotificationTapped,
      onDidReceiveBackgroundNotificationResponse:
          _onLocalNotificationTappedBackground,
    );
  }

  /// Android notification channels create करते.
  ///
  /// Android 8+ वर प्रत्येक notification ला channel आवश्यक असते.
  /// Channels:
  /// - `high_importance_channel` — important alerts
  /// - `marketing_channel` — promotional messages
  Future<void> _createAndroidChannels() async {
    if (!Platform.isAndroid) {
      return;
    }

    final androidPlugin = _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    if (androidPlugin == null) {
      return;
    }

    await androidPlugin.createNotificationChannel(
      const AndroidNotificationChannel(
        NotificationConstants.defaultChannelId,
        NotificationConstants.defaultChannelName,
        description: NotificationConstants.defaultChannelDescription,
        importance: Importance.high,
        playSound: true,
        enableVibration: true,
      ),
    );

    await androidPlugin.createNotificationChannel(
      const AndroidNotificationChannel(
        NotificationConstants.marketingChannelId,
        NotificationConstants.marketingChannelName,
        description: NotificationConstants.marketingChannelDescription,
        importance: Importance.defaultImportance,
      ),
    );
  }

  /// iOS वर app foreground मध्ये असताना notification banner दाखवण्यासाठी configure करते.
  /// Alert, badge, sound — तीनही enable करते.
  Future<void> _configureForegroundPresentation() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await _messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  /// FCM message handlers register करते.
  ///
  /// `onMessage` — app open (foreground) असताना message आल्यावर.
  ///              Local notification banner दाखवते.
  /// `onMessageOpenedApp` — app background मध्ये असताना user ने notification tap केल्यावर.
  Future<void> _registerMessageHandlers() async {
    FirebaseMessaging.onMessage.listen((message) async {
      final appNotification = AppNotification.fromRemoteMessage(message);
      _receivedController.add(appNotification);

      if (kDebugMode) {
        debugPrint('[FCM Foreground] ${appNotification.title}');
      }

      await _showLocalNotification(appNotification);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _dispatchOpenedNotification(AppNotification.fromRemoteMessage(message));
    });
  }

  /// App completely बंद (terminated) होता तेव्हा notification tap करून
  /// app launch झाले का ते check करते.
  /// Launch notification असेल तर `_dispatchOpenedNotification` call करते.
  Future<void> _handleLaunchNotification() async {
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _dispatchOpenedNotification(
        AppNotification.fromRemoteMessage(initialMessage),
      );
    }
  }

  /// Device notification tray वर local notification दाखवते.
  ///
  /// [notification] — दाखवायच्या notification चा AppNotification object.
  /// Android: channel, icon, big text style set करते.
  /// iOS: alert, badge, sound enable करते.
  /// Payload encode करून tap वेळी data परत मिळवता येतो.
  Future<void> _showLocalNotification(AppNotification notification) async {
    final channelId =
        notification.channelId ?? NotificationConstants.defaultChannelId;

    final androidDetails = AndroidNotificationDetails(
      channelId,
      channelId == NotificationConstants.marketingChannelId
          ? NotificationConstants.marketingChannelName
          : NotificationConstants.defaultChannelName,
      channelDescription: channelId == NotificationConstants.marketingChannelId
          ? NotificationConstants.marketingChannelDescription
          : NotificationConstants.defaultChannelDescription,
      importance: Importance.high,
      priority: Priority.high,
      icon: NotificationConstants.androidNotificationIcon,
      styleInformation: notification.body.isNotEmpty
          ? BigTextStyleInformation(notification.body)
          : null,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      id: notification.id?.hashCode ?? DateTime.now().millisecondsSinceEpoch,
      title: notification.title,
      body: notification.body,
      notificationDetails: details,
      payload: notification.encodePayload(),
    );
  }

  /// Notification opened event सर्व listeners ला dispatch करते.
  ///
  /// [notification] — tap झालेली notification.
  /// `onNotificationOpened` stream emit करते आणि optional `_onNotificationTap` callback call करते.
  void _dispatchOpenedNotification(AppNotification notification) {
    _openedController.add(notification);
    _onNotificationTap?.call(notification);

    if (kDebugMode) {
      debugPrint(
        '[FCM Opened] route=${notification.route} data=${notification.data}',
      );
    }
  }

  /// User ने local notification tap केल्यावर call होते (app foreground/background).
  ///
  /// [response] — tap details (id, payload, action).
  /// Response ला AppNotification मध्ये convert करून dispatch करते.
  void _onLocalNotificationTapped(NotificationResponse response) {
    _dispatchOpenedNotification(
      AppNotification.fromNotificationResponse(response),
    );
  }

  /// User ने local notification tap केल्यावर call होते (app terminated isolate).
  ///
  /// Top-level static function असावी लागते — background isolate साठी.
  /// `@pragma('vm:entry-point')` = Dart compiler हे function remove करत नाही.
  @pragma('vm:entry-point')
  static void _onLocalNotificationTappedBackground(
    NotificationResponse response,
  ) {
    if (kDebugMode) {
      debugPrint('[Local Notification Background Tap] id=${response.id}');
    }
  }
}
