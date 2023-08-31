
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/http/entities/http_response.dart';
import '../repositories/user_repository.dart';

class DeleteUser{
  final UserRepository _userRepository;

  DeleteUser(this._userRepository);

  Future<Either<Failure,HttpSuccess>> call() async {
    return await _userRepository.deleteUser();
  }
}