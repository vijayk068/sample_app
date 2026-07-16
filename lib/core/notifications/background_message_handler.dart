import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import '../../firebase_options.dart';
import 'notification_service.dart';

/// Handles FCM data messages while the app is terminated or in background.
///
/// Must remain a top-level function and be registered before [runApp].
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (kDebugMode) {
    debugPrint(
      '[FCM Background] id=${message.messageId} data=${message.data}',
    );
  }

  await NotificationService.instance.handleBackgroundMessage(message);
}
