abstract interface class PushNotificationRepository {
  Future<void> init();
  void dispose();
  Future<String?> getDeviceToken();
  Stream<Map<String,dynamic>?> get onNotificationReceived;
}