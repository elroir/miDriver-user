import 'dart:async';

import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'push_notification_repository.dart';


class PushNotificationImpl implements PushNotificationRepository{
  final StreamController<Map<String, dynamic>?> _notificationData = StreamController.broadcast();

  @override
  Future<String?> getDeviceToken() async {
    final state = await OneSignal.shared.getDeviceState();
    if(state!=null){
      return state.userId;
    }
    return null;
  }

  @override
  Future<void> init() async { //Remove this method to stop OneSignal Debugging
    // OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.setAppId('d10eb845-9354-421c-b259-176080047de1');

    // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    });

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult event) {

      _notificationData.sink.add(event.notification.additionalData);

    });


    OneSignal.shared.setNotificationWillShowInForegroundHandler((OSNotificationReceivedEvent event) {
      // Will be called whenever a notification is received in foreground
      // Display Notification, pass null param for not displaying the notification
      _notificationData.sink.add(event.notification.additionalData);
      event.complete(event.notification);
    });

  }

  @override
  Stream<Map<String, dynamic>?> get onNotificationReceived => _notificationData.stream;

  @override
  void dispose(){
    _notificationData.close();
  }

  @override
  Future<void> requestNotificationPermission() async {
    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    });
  }

}