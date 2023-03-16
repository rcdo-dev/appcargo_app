import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

NotificationDetails get _defaultType {
  final androidChannelSpecifics = AndroidNotificationDetails(
    'your_channel_id',
    'your_channel_name',
    'your_channel_description',
    importance: Importance.Max,
    priority: Priority.High,
    ongoing: false,
    autoCancel: true,
//    sound: "alarm",
    icon: "app_icon"
  );

  final iOSChannelSpecifics = IOSNotificationDetails();
  return NotificationDetails(androidChannelSpecifics, iOSChannelSpecifics);
}

Future showDefaultNotification(
  FlutterLocalNotificationsPlugin notifications, {
  @required String title,
  @required String body,
  String payload,
  int id = 0,
}) =>
    _showNotification(notifications,
        title: title, body: body, id: id, type: _defaultType, payload: payload);

Future _showNotification(
  FlutterLocalNotificationsPlugin notifications, {
  @required String title,
  @required String body,
  @required NotificationDetails type,
  String payload,
  int id = 0,
}) =>
    notifications.show(id, title, body, type, payload: payload);
