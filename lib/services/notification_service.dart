import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Native system-tray notifications for Botanisht.
///
/// Used to push severe-weather advisories (storm / frost / freeze) to the
/// device notification tray so the user is warned even when the app is
/// backgrounded or the phone is locked. Backed by
/// `flutter_local_notifications` with a single high-importance Android
/// channel (`weather_alerts`).
class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static const String _channelId = 'weather_alerts';
  static const String _channelName = 'Weather Alerts';
  static const String _channelDescription =
      'Storm, frost, and severe-weather advisories for your garden';

  bool _initialized = false;

  /// Idempotently configures the plugin, creates the Android channel, and
  /// requests the runtime notification permission on Android 13+.
  Future<void> initialize() async {
    if (_initialized) return;
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    await _plugin.initialize(initSettings);

    final android = _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    await android?.createNotificationChannel(
      const AndroidNotificationChannel(
        _channelId,
        _channelName,
        description: _channelDescription,
        importance: Importance.high,
      ),
    );
    // On Android 13+ (API 33+) posting notifications requires a runtime
    // permission; requesting it up front lets the weather advisory reach the
    // tray without a second prompt.
    await android?.requestNotificationsPermission();

    _initialized = true;
  }

  /// Pushes the severe-weather advisory to the system tray.
  Future<void> showWeatherAlert() async {
    if (!_initialized) {
      // Best-effort recovery if init was somehow missed before a trigger.
      try {
        await initialize();
      } catch (_) {
        return;
      }
    }
    const androidDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDescription,
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );
    const details = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );
    await _plugin.show(
      1,
      'Weather Alert',
      'Storm alert: Move your outdoor crops inside!',
      details,
    );
  }
}
