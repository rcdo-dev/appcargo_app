import 'package:app_cargo/domain/custom_notification/custom_notificaion.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class AppNotificationService {
  FlutterLocalNotificationsPlugin localNotificationsPlugin;
  AndroidNotificationDetails androidDetails;

  AppNotificationService() {
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _setupNotifications();
  }

  _setupNotifications() async {
    await _setupTimezone();
    await _initializeNotifications();
  }

  Future<void> _setupTimezone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  _initializeNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');

    await localNotificationsPlugin.initialize(
      const InitializationSettings(
        android,
        null,
      ),
      onSelectNotification: _onSelectNotification,
    );
  }

  Future<dynamic> _onSelectNotification(String payload) async {
    if (payload != null && payload.isNotEmpty) {
      print(payload);
    }
  }

  showNotification(CustomNotification notification) {
    androidDetails = const AndroidNotificationDetails(
      'lembretes_notifications_x',
      'Lembretes',
      'Este canal é para lembretes',
      importance: Importance.Max,
      priority: Priority.Max,
      enableVibration: true,
    );

    localNotificationsPlugin.show(
      notification.id,
      notification.title,
      notification.body,
      NotificationDetails(
        androidDetails,
        null,
      ),
      payload: notification.payload,
    );
  }

  checkForNotifications() async {
    final details = await localNotificationsPlugin.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      _onSelectNotification(details.payload);
    }
  }
}
