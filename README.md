# crop2x_push_notifications

### Dependencies: 
 ``firebase_core:``
 
 ``firebase_messaging:``
 
 ``get:``

## Step 1: Connecting Flutter app to Firebase

1. Add ``firebase_core`` to pubspec.yaml from Pub.dev
2. To initialize, (you must have firebase installed on device (``npm i -g firebase-tools``))
3. Open powershell as administrator -> Login to firebase (``firebase login``)
4. goto project directory
5. Install Firebase_cli: ``dart pub global activate flutterfire_cli``
6. Configure firebase project and platforms : `` firebase configure`` -> It will generate ``firebase_options.dart``

## Initializing Firebase
Modify ``main.dart``:

import these packages: 
``` 
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

```
update main function: '

``` 
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized(
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, 
  );
  runApp(const MyApp());
}
```
## Adding Firebase Messaging service: 

 Add dependency ``firebase_messaging:any`` to pubspec.yaml or run cmd ``flutter pub add firebase_messaging``
 
 **Create Channel :** 
 
 Goto `` android\app\src\main\AndroidMenifest.xml ``
 
 add this: 
 ```
 <meta-data
  android:name="com.google.firebase.messaging.default_notification_channel_id"
  android:value="<channel_name>" />
  ```
  
  ## Getting Push Notifications streams: 
  
  #### For foreground notifications: 
  
  ```
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  RemoteNotification notification = message.notification!;
  AndroidNotification? android = message.notification!.android;

  if (notification != null && android != null) {
    print(notification.title);
  }
});

```

#### For Background Notifications while app isn't terminated and running in the background but user isn't currently using it: 

**Creating background message handler before main function:**

```

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
    );
  print('Handling a background message ${message.messageId}');
}
```

**Getting background messages handler in main function:**
```
FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
```
 so main function will be like this :
 
 ```
  Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized(
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, 
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

```

**Handling Background Messages while app is in terminated state:**
```
FirebaseMessaging.instance.getInitialMessage().then((message){
      if(message != null){
        String routeFromMessage = message.data['route'];
        print(message.notification?.title);
        print(message.notification?.body);
        Get.toNamed('/$routeFromMessage');

      }
    });

```

**Handling user tap or when user clicks the notification:**
```
FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) { 
  if(message != null){
    final route = message.data['route'];
    Get.toNamed("/$route");

  }
});
```

## Adding ``flutter_local_notifications`` package to create head up when notification arrived: 

1. Add dependency to ``pubspec.yaml``
2. import package in your code
3. creating channel and initializing notifications setting: 

```
class LocalNotificationService {
// creating instance of notification plugin 
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();


  static void initialize() async {
    const InitializationSettings _initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    // initializing ``flutter_local_notifications`` package
    flutterLocalNotificationsPlugin.initialize(
      _initializationSettings,
      // getting paramters or payloads from message data
      
      onSelectNotification: (String? route) {
        if(route != null) {
          Get.toNamed("/$route");
        }
      },
    );
  }

// displaying pop up 
  static void display(RemoteMessage message) async {
    try {
    
    //creating channel
    
    const NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
        'test_channel',
        'Test Application Channel',
        channelDescription: 'This is my test channel',
        importance: Importance.max,
        priority: Priority.high,
        icon: "@mipmap/ic_launcher",
      ));
      
      // show pop up 
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


```

Let's call this: 
First initialize Flutter Local Notifications Service in main, 

`` LocalNotificationService.initialize(); ``

Now, our main will be like : 

```
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
```

Now call ``LocalNotificationService.display(message)`` where you want to show pop up. 

For example: 
Adding pop up to foreground notifications: 

```
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  RemoteNotification notification = message.notification!;
  AndroidNotification? android = message.notification!.android;
  
  if (notification != null && android != null) {
    LocalNotificationService.display(message); // display pop up
    print(notification.title);
  }
});

```



***The End***


