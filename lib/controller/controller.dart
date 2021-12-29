import 'package:crop2x/service/local_notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';

class Controller extends GetxController{
  @override 
  void onInit(){
    super.onInit();
    print('entring init');
    FirebaseMessaging.instance.getInitialMessage().then((message){
      if(message != null){
        String routeFromMessage = message.data['route'];
        print(message.notification?.title);
        print(message.notification?.body);
        Get.toNamed('/$routeFromMessage');

      }
      else{
        print('there is an error');
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  RemoteNotification notification = message.notification!;
  AndroidNotification? android = message.notification!.android;

  // If `onMessage` is triggered with a notification, construct our own
  // local notification to show to users using the created channel.
  if (notification != null && android != null) {
    LocalNotificationService.display(message);
    print(notification.title);
  }
});
FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) { 
  if(message != null){
    final route = message.data['route'];
    Get.toNamed("/$route");

  }
});
  
  }
}