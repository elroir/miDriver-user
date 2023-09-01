abstract interface class PushNotificationRepository {
  Future<void> init();
  void dispose();
  Future<String?> getDeviceToken();
  Future<void> requestNotificationPermission();

  Stream<Map<String,dynamic>?> get onNotificationReceived;
}