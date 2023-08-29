
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/use_cases/get_notification_data_use_case.dart';
import '../../../../repositories.dart';

final notificationDataProvider = StateNotifierProvider<NotificationDataNotifier,Map<String,dynamic>?>(
        (ref) => NotificationDataNotifier(ref.read(Repositories.getNotificationDataUseCase))
);


class NotificationDataNotifier extends StateNotifier<Map<String,dynamic>?> {

  final GetNotificationDataStream _notificationDataStream;

  NotificationDataNotifier(this._notificationDataStream) : super(null) {
    _notificationDataStream().listen((event) {
      state = event;
    });
  }


}