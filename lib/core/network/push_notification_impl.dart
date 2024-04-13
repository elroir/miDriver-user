import 'dart:async';

import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'push_notification_repository.dart';


class PushNotificationImpl implements PushNotificationRepository{
  final StreamController<Map<String, dynamic>?> _notificationData = StreamController.broadcast();

  @override
  Future<String?> getDeviceToken() async {
    return OneSignal.User.pushSubscription.id;
  }

  @override
  Future<void> init() async { //Remove this method to stop OneSignal Debugging
    // OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.initialize('d10eb845-9354-421c-b259-176080047de1');

    // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    OneSignal.Notifications.requestPermission(true);


    OneSignal.Notifications
        .addClickListener((event) {

      _notificationData.sink.add(event.notification.additionalData);

    });


    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      event.preventDefault();

      _notificationData.sink.add(event.notification.additionalData);
      event.notification.display();
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
    OneSignal.Notifications.requestPermission(true);
  }

}