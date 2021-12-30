import 'package:crop2x/fcm_push_notifications/ui/home.dart';
import 'package:crop2x/fcm_push_notifications/ui/pink.dart';
import 'package:crop2x/fcm_push_notifications/ui/purple.dart';
import 'package:crop2x/main.dart';
import 'package:get/route_manager.dart';

class Routes {
  static const home = '/home';
  static const pink = '/pink';
  static const purple = '/purple';
  static const tellotalk = '/tello_talk_sdk';
}

class AddPages{
  static final pages = [
    GetPage(name: Routes.home, page: ()=> TestingScreen()),
    GetPage(name: Routes.pink, page: ()=> const Pink()),
    GetPage(name: Routes.purple, page: ()=> const Purple()),
    GetPage(name: Routes.tellotalk, page: ()=> const TelloTalkSdkTesting()),



  ];
}