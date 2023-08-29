import '../push_notification_repository.dart';

class GetNotificationDataStream {
  final PushNotificationRepository _notificationRepository;

  GetNotificationDataStream(this._notificationRepository);

  Stream<Map<String, dynamic>?> call() => _notificationRepository.onNotificationReceived;

}
