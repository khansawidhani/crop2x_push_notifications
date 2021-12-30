// ignore_for_file: unnecessary_null_comparison

import 'package:crop2x/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'fcm_push_notifications/service/local_notification_service.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';



/// To verify things are working, check out the native platform logs.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
    );
  LocalNotificationService.display(message);
  print('Handling a background message ${message.messageId}');
}

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized(
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, 
  );
  LocalNotificationService.initialize();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/tello_talk_sdk',
      getPages:AddPages.pages
    );
  }
}

class TelloTalkSdkTesting extends StatelessWidget {
  const TelloTalkSdkTesting({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Center(
        child: Text('Tello Talk Sdk testing', style: TextStyle(fontSize: 22.0)),
      )),
    );
  }
}