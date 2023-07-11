
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/http/entities/http_response.dart';
import '../../../../core/network/push_notification_repository.dart';
import '../repositories/user_repository.dart';

class UpdateUserToken{
  final PushNotificationRepository _pushNotificationRepository;
  final UserRepository _userRepository;

  UpdateUserToken(this._pushNotificationRepository,this._userRepository);

  Future<Either<Failure,HttpSuccess>> call() async {
    await _pushNotificationRepository.init();
      return await _userRepository.updatePushToken();
  }
}