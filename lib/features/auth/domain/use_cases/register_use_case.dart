
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/http/entities/http_response.dart';
import '../repositories/auth_repository.dart';

class SignUp{

  final AuthRepository _authRepository;

  SignUp(this._authRepository);

  Future<Either<Failure,HttpSuccess>> call() async {
    final registerOrFailure = await _authRepository.signUp();
    return registerOrFailure.fold(
            (error) => Left(error),
            (ok)  => _authRepository.user.fold(
                (error) => Left(error),
                (user) async {
              final loginOrFailure = await _authRepository.signInWithEmail(user);
              return loginOrFailure.fold(
                      (e) => Left(e),
                      (s) => Right(s)
              );
            }
        )

    );

  }

}