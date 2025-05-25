// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
//
// import 'package:amplify_core/amplify_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// import '../utils/logger_util.dart';
// import 'push_notification_entity.dart';
//
// class NotificationManager {
//   bool iosNotify = false;
//
//   late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//
//   Future<void> init() async {
//     await initializeLocalNotifications();
//     await cloudMessagingListener();
//   }
//
//   static Future<void> _iOSPermission() async {
//     await FirebaseMessaging.instance.requestPermission(
//       sound: true,
//       badge: true,
//       alert: true,
//     );
//
//     FirebaseMessaging.instance.getNotificationSettings();
//   }
//
//   Future<void> initializeLocalNotifications() async {
//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//     // Initializing Notification Plugin
//     flutterLocalNotificationsPlugin.initialize(
//       const InitializationSettings(
//           android: AndroidInitializationSettings('@mipmap/ic_launcher'),
//           iOS: DarwinInitializationSettings(
//               // requestAlertPermission: true,
//               // requestBadgePermission: true,
//               // requestSoundPermission: false,
//               // onDidReceiveLocalNotification: (id, title, body, payload) async {
//               // Your call back to the UI
//               // This property is only applicable to iOS versions older than 10.
//               // },
//               )),
//       onDidReceiveBackgroundNotificationResponse: _onSelectNotification,
//       onDidReceiveNotificationResponse: _onSelectFrontNotification,
//     );
//
//     if (Platform.isIOS) {
//       await flutterLocalNotificationsPlugin
//           .resolvePlatformSpecificImplementation<
//               IOSFlutterLocalNotificationsPlugin>()
//           ?.requestPermissions();
//     } else {
//       await flutterLocalNotificationsPlugin
//           .resolvePlatformSpecificImplementation<
//               AndroidFlutterLocalNotificationsPlugin>()
//           ?.requestNotificationsPermission();
//     }
//   }
//
//   Future<void> cloudMessagingListener() async {
//     if (Platform.isIOS) {
//       _iOSPermission();
//     }
//
//     // Get any messages which caused the application to open from a terminated state.
//     FirebaseMessaging.instance
//         .getInitialMessage()
//         .then((RemoteMessage? message) {
//       // Firebase.initializeApp();
//
//       safePrint("FirebaseMessaging.getInitialMessage=======> $message");
//
//       if (message != null) {
//         Future.delayed(const Duration(seconds: 3), () {
//           PushNotificationEntity p = PushNotificationEntity.fromJson(
//               jsonDecode(jsonEncode(message.data)));
//
//           iosNotify = true;
//           redirectNotification(p, true);
//         });
//       }
//     });
//
//     // When is in Foreground || Already Open
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       RemoteNotification? notification = message.notification;
//       // AndroidNotification? android = message.notification?.android;
//
//       logger.w('p.runtimeType==onMessage=> ${message.toString()}');
//       logger.w('p.runtimeType=map=onMessage=> ${message.toMap()}');
//       logger.w('p.runtimeType=[other=onMessage=> ${message.data}');
//       logger.w('p.runtimeType=body=onMessage=> ${notification?.body!}');
//       logger.w('p.runtimeType=data=onMessage=> ${message.data.toString()}');
//
//       if (!iosNotify) {
//         showNotification(message.notification?.title ?? "",
//             message.notification?.body ?? "", jsonEncode(message.data));
//       } else {
//         iosNotify = false;
//       }
//     });
//
//     // When Opened Via Notificiation
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       RemoteNotification notification = message.notification!;
//
//       safePrint(
//           "onMessageOpenedApp message.notification.body:- ${message.data.toString()}");
//       safePrint(
//           "onMessageOpenedApp notification.title:-  ${notification.title.toString()}");
//
//       PushNotificationEntity p =
//           PushNotificationEntity.fromJson(jsonDecode(jsonEncode(message.data)));
//
//       iosNotify = true;
//       redirectNotification(p, false);
//     });
//
//     // When in Background or Terminated State
//     FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
//
//     // Sets the presentation options for Apple notifications when received in the foreground.
//     FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//       alert: false,
//       badge: false,
//       sound: false,
//     );
//   }
//
//   // Cloud Messaging Methods
//   static Future<dynamic> onBackgroundMessage(RemoteMessage message) async {
//     // final String daata = message.data.toString();
//     // final List<String> str =
//     // daata.replaceAll('{', '').replaceAll('}', '').split(',');
//     // final Map<String, dynamic> result = <String, dynamic>{};
//     // for (int i = 0; i < str.length; i++) {
//     //   final List<String> s = str[i].split(':');
//     //   result.putIfAbsent(s[0].trim(), () => s[1].trim());
//     // }
//     // print(result);
//     //
//     // if (result["type"] != null) {
//     //   DeepLinking.GoTo(
//     //       int.parse(result["type"]),
//     //       int.parse(result["redirect_on"]),
//     //       int.parse(result["redirect_on"]),
//     //       buildContext);
//     // }
//   }
//
//   /// Local Notification Plugin Methods
//   static _onSelectFrontNotification(NotificationResponse? payload) async {
//     // if (kDebugMode) {
//     //   print("onSelectNotification==? $onSelectFrontNotification");
//     // }
//     // PushNotificationEntity p =
//     // PushNotificationEntity.fromJson(jsonDecode(data));
//     // redirectNotification(p, false);
//   }
//
//   static _onSelectNotification(NotificationResponse? payload) async {
//     // if (kDebugMode) {
//     //   print("onSelectNotification==? $onSelectFrontNotification");
//     // }
//     // PushNotificationEntity p =
//     // PushNotificationEntity.fromJson(jsonDecode(data));
//     // redirectNotification(p, false);
//   }
//
//   Future<void> showNotification(
//       String? title, String? body, String param) async {
//     // Android Notification Info
//     var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
//         'Push Notifications', 'Push Notifications description',
//         importance: Importance.max,
//         playSound: true,
//         sound: RawResourceAndroidNotificationSound(""),
//         showProgress: true,
//         priority: Priority.high,
//         ticker: 'test ticker');
//
//     // iOS Notification Info
//     var iOSChannelSpecifics = const DarwinNotificationDetails();
//
//     await flutterLocalNotificationsPlugin.show(
//         0,
//         title,
//         body,
//         NotificationDetails(
//             android: androidPlatformChannelSpecifics, iOS: iOSChannelSpecifics),
//         payload: param);
//   }
//
//   redirectNotification(PushNotificationEntity p, bool isFromTerminatedState) =>
//       logger.e("notification redirect hear now");
// }
