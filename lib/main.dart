import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:sample_app/features/login/login.dart';
import 'package:sample_app/page1.dart';
import 'package:sample_app/page3.dart';
import 'package:sample_app/page_2.dart';

import 'core/notifications/background_message_handler.dart';
import 'core/notifications/models/app_notification.dart';
import 'core/notifications/notification_service.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // await NotificationService.instance.initialize(
  //   onNotificationTap: _handleNotificationTap,
  // );

  // await NotificationService.instance.requestPermissions();

  runApp(const SampleApp());
}

void _handleNotificationTap(AppNotification notification) {
  debugPrint(
    'Notification opened: ${notification.title} -> ${notification.route}',
  );
}

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Page2(),
    );
  }
}

class NotificationHomePage extends StatefulWidget {
  const NotificationHomePage({super.key});

  @override
  State<NotificationHomePage> createState() => _NotificationHomePageState();
}

class _NotificationHomePageState extends State<NotificationHomePage> {
  String? _fcmToken;
  String _permissionStatus = 'Checking...';
  String _lastNotification = 'No notifications yet';

  @override
  void initState() {
    super.initState();
    _loadNotificationState();

    NotificationService.instance.onNotificationReceived.listen((notification) {
      setState(() {
        _lastNotification = '${notification.title}: ${notification.body}';
      });
    });

    NotificationService.instance.onNotificationOpened.listen((notification) {
      setState(() {
        _lastNotification = 'Opened -> ${notification.title}';
      });
    });

    NotificationService.instance.onTokenRefresh.listen((token) {
      setState(() {
        _fcmToken = token;
      });
    });
  }

  Future<void> _loadNotificationState() async {
    final token = await NotificationService.instance.getToken();
    final settings = await NotificationService.instance.getPermissionStatus();

    if (!mounted) {
      return;
    }

    setState(() {
      _fcmToken = token;
      _permissionStatus = settings.authorizationStatus.name;
    });
  }

  Future<void> _requestPermissions() async {
    final granted = await NotificationService.instance.requestPermissions();
    await _loadNotificationState();

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          granted
              ? 'Notification permission granted'
              : 'Notification permission denied',
        ),
      ),
    );
  }

  Future<void> _sendTestNotification() async {
    final granted = await NotificationService.instance.requestPermissions();
    if (!granted && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please allow notifications first')),
      );
      return;
    }

    await NotificationService.instance.showTestLocalNotification(
      title: 'Hello from Sample App',
      body: 'Check your notification tray on the home screen.',
      route: '/home',
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _lastNotification = 'Test sent — minimize app to see it on home screen';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Notification sent! Press home button or swipe down to see it.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Push Notifications'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _InfoCard(title: 'Permission Status', value: _permissionStatus),
              const SizedBox(height: 12),
              _InfoCard(title: 'FCM Token', value: _fcmToken ?? 'Unavailable'),
              const SizedBox(height: 12),
              _InfoCard(title: 'Last Notification', value: _lastNotification),
              const Spacer(),
              FilledButton.icon(
                onPressed: _sendTestNotification,
                icon: const Icon(Icons.send_outlined),
                label: const Text('Send Test Notification'),
              ),
              const SizedBox(height: 8),
              FilledButton.icon(
                onPressed: _requestPermissions,
                icon: const Icon(Icons.notifications_active_outlined),
                label: const Text('Request Permission'),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: _loadNotificationState,
                icon: const Icon(Icons.refresh),
                label: const Text('Refresh Token'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            SelectableText(
              value,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
