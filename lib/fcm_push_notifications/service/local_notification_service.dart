import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class LocalNotificationService {

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() async {
    const InitializationSettings _initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    flutterLocalNotificationsPlugin.initialize(
      _initializationSettings,
      onSelectNotification: (String? route) {
        if(route != null) {
          Get.toNamed("/$route");
        }
      },
    );
  }

  static void display(RemoteMessage message) async {
    try {
      const NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
        'test_channel',
        'Test Application Channel',
        channelDescription: 'This is my test channel',
        importance: Importance.max,
        priority: Priority.high,
        icon: "@mipmap/ic_launcher",
      ));
      await flutterLocalNotificationsPlugin.show(
          message.notification.hashCode, // id
          message.notification?.title, // title
          message.notification?.body, // body
          notificationDetails, // notification details for the platforms
          payload: message.data['route'] // recieved parameters
          );
    } on Exception catch (e) {
      print(e);
    }
  }
}
