/*
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/core/firebase/push_notification_model.dart';


class FirebaseMessageCubit extends Cubit<PushNotificationModel> {
  static const int OTHER_SCREEN = 1;
  static const int CHAT_LIST_SCREEN = 2;
  static const int CHAT_DETAIL_SCREEN = 3;

  //We will use this two variables two determine the current selected screen is chat screen or not.
  //If it is chat detail screen then we will check the current selected chat id
  //If the current selected chat id matches with the chat id with whom we are chatting then we don't need to show notification
  //Other wise we will show the notification.
  int _currentScreen = OTHER_SCREEN;
  int _currentSelectedChatID = -1;

  FirebaseMessageCubit() : super(null);

  Future<void> initializeFCM() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    if (Platform.isIOS) {
      //We need to ask for permission on the ios that's why we are putting this at the time of initialization.
      //For more information visit - https://firebase.flutter.dev/docs/messaging/usage#requesting-permission-apple--web
      var notificationSettings = await messaging.requestPermission();
      if (notificationSettings.authorizationStatus ==
              AuthorizationStatus.denied ||
          notificationSettings.authorizationStatus ==
              AuthorizationStatus.notDetermined) {
        //Permission is not granted here, we will show the dialog to user in every role's main screen.
        //i.e. DriverMainScreen, CustomerMainScreen and BusinessMainScreen
        //We can check the permission status again via messaging.getNotificationSettings()
        return;
      }
    }

    //This is done to display the notification when the application is in foreground. This for the ios.
    //If notification are showing after creating manually then no need to use this.
    //More on this - https://firebase.flutter.dev/docs/messaging/notifications#foreground-notifications
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    //If the application is in foreground we will get the message in this stream.
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Notification is here in foreground ${message.messageId}");
      print("Notification data payload ${message.data}");
      var pushModel = _createPushModel(message);
      showNotification(pushModel);
    });
  }

  void showNotification(PushNotificationModel pushModel) {
    var notificationData = pushModel.data;
    bool needToShowNotification = true;
    //Checking if push notification type is chat and our current open screen is chat list or chat detail screen.
    //Then we need to perform some checks to determine weather to show notification or not.
    if (pushModel.notificationType == NotificationConstant.CHAT_TYPE &&
        (_currentScreen == CHAT_LIST_SCREEN ||
            _currentScreen == CHAT_DETAIL_SCREEN)) {
      if (_currentScreen == CHAT_LIST_SCREEN) {
        //Here we will show the notification. but we will not update the chat list screen.
        //We will show a banner to tell user to refresh the screen so that user will know about the new message.
      } else {
        //Here it is chat detail screen.
        var chatID =
            int.tryParse(notificationData[NotificationConstant.CHAT_ID_KEY]);
        if (chatID == _currentSelectedChatID) needToShowNotification = false;
      }
    }

    if (needToShowNotification) {
      NotificationManager.instance
          .showNotification(pushModel.notificationID, notificationData);
      emit(pushModel);
    }
  }

  PushNotificationModel _createPushModel(RemoteMessage message) {
    var data = message.data;
    var pushNotificationModel = PushNotificationModel()
      ..data = data
      ..notificationID = message.hashCode
      ..notificationType =
          int.tryParse(data[NotificationConstant.NOTIFICATION_TYPE_KEY]);
    return pushNotificationModel;
  }

  void updateCurrentVisibleScreen(int currentVisibleScreen) {
    this._currentScreen = currentVisibleScreen;
    if(_currentScreen != CHAT_DETAIL_SCREEN)
      _currentSelectedChatID = -1;
  }

  void updateCurrentSelectedChatID(int currentSelectedChatID) {
    this._currentSelectedChatID = currentSelectedChatID;
  }

  int getCurrentSelectedScreen(){
    return _currentScreen;
  }

  int getCurrentSelectedChatID(){
    return _currentSelectedChatID;
  }
}

//If the application is in background and in terminated state we will get the message in this handler.
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  NotificationManager.instance.showNotification(message.hashCode, message.data);
}
*/
