/// Centralized notification identifiers used across Android and iOS.
abstract final class NotificationConstants {
  static const String defaultChannelId = 'high_importance_channel';
  static const String defaultChannelName = 'Important Alerts';
  static const String defaultChannelDescription =
      'Critical alerts, account updates, and time-sensitive messages.';

  static const String marketingChannelId = 'marketing_channel';
  static const String marketingChannelName = 'Promotions';
  static const String marketingChannelDescription =
      'Offers, product updates, and promotional content.';

  static const String androidNotificationIcon = '@drawable/ic_notification';

  static const String dataKeyRoute = 'route';
  static const String dataKeyType = 'type';
  static const String dataKeyId = 'id';
}
