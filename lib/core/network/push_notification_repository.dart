abstract interface class PushNotificationRepository {
  Future<void> init();
  Future<String?> getDeviceToken();
}