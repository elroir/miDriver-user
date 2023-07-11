import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetUserData{
  final UserRepository _userRepository;

  GetUserData(this._userRepository);

  Future<Either<Failure,User>> call() async {
    return await _userRepository.getUser();
  }
}