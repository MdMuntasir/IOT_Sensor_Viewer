import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final _notificationPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    const initAndroid = AndroidInitializationSettings("@mipmap/ic_launcher");

    const initSetting = InitializationSettings(android: initAndroid);

    await _notificationPlugin.initialize(initSetting);
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
      "iot_channel_id",
      "IOT Notifications",
      priority: Priority.high,
      importance: Importance.max,
    ));
  }

  Future<void> showNotification({
    int id=0,
    required String title,
    required String body,
  }) async {

    await _notificationPlugin.show(
      id,
      title,
      null,
      NotificationDetails(
          android: AndroidNotificationDetails(
            "iot_channel_id",
            "IOT Notifications",
            priority: Priority.high,
            importance: Importance.max,
            styleInformation: BigTextStyleInformation(body),
          )
      ),
    );
  }
}
