import 'package:fpdart/fpdart.dart';
import '../../../../core/http/entities/http_response.dart';

import '../../../../core/error/failures.dart';
import '../entities/auth_user.dart';
import '../repositories/auth_repository.dart';

class SignInWithEmail{

  final AuthRepository _authRepository;

  SignInWithEmail(this._authRepository);

  Future<Either<Failure,HttpSuccess>> call(String email,String password) async {
    final userRoleOrFailure = await _authRepository.verifyRole(email);

    return userRoleOrFailure.fold(
            (error) => Left(error),
            (success) async {
              final user = AuthUser(email: email, password: password);
              final loginOrFailure = await _authRepository.signInWithEmail(user);
              return loginOrFailure;
            }
    );

  }

}