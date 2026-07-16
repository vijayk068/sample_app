import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../notification_constants.dart';

/// Normalized in-app representation of a push or local notification.
class AppNotification {
  const AppNotification({
    required this.title,
    required this.body,
    required this.data,
    required this.receivedAt,
    this.id,
    this.channelId,
    this.imageUrl,
  });

  final String? id;
  final String title;
  final String body;
  final Map<String, dynamic> data;
  final DateTime receivedAt;
  final String? channelId;
  final String? imageUrl;

  String? get route => data[NotificationConstants.dataKeyRoute] as String?;
  String? get type => data[NotificationConstants.dataKeyType] as String?;

  factory AppNotification.fromRemoteMessage(RemoteMessage message) {
    final notification = message.notification;

    return AppNotification(
      id: message.messageId,
      title: notification?.title ?? message.data['title'] as String? ?? 'Notification',
      body: notification?.body ?? message.data['body'] as String? ?? '',
      data: Map<String, dynamic>.from(message.data),
      receivedAt: message.sentTime ?? DateTime.now(),
      channelId: message.notification?.android?.channelId,
      imageUrl: notification?.android?.imageUrl ?? notification?.apple?.imageUrl,
    );
  }

  factory AppNotification.fromNotificationResponse(
    NotificationResponse response,
  ) {
    final payload = response.payload;
    final data = <String, dynamic>{};

    if (payload != null && payload.isNotEmpty) {
      for (final part in payload.split('&')) {
        final separatorIndex = part.indexOf('=');
        if (separatorIndex == -1) {
          continue;
        }
        final key = part.substring(0, separatorIndex);
        final value = part.substring(separatorIndex + 1);
        data[key] = Uri.decodeComponent(value);
      }
    }

    return AppNotification(
      id: response.id?.toString(),
      title: data['title'] as String? ?? 'Notification',
      body: data['body'] as String? ?? '',
      data: data,
      receivedAt: DateTime.now(),
      channelId: data['channelId'] as String?,
    );
  }

  String encodePayload() {
    final entries = <String>[
      'title=${Uri.encodeComponent(title)}',
      'body=${Uri.encodeComponent(body)}',
      if (channelId != null) 'channelId=${Uri.encodeComponent(channelId!)}',
      ...data.entries.map(
        (entry) =>
            '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent('${entry.value}')}',
      ),
    ];

    return entries.join('&');
  }
}
