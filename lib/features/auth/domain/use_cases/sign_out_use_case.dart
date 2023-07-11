import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/http/entities/http_response.dart';
import '../repositories/auth_repository.dart';

class SignOut{

  final AuthRepository _authRepository;

  SignOut(this._authRepository);

  Future<Either<Failure,HttpSuccess>> call() async {
    final registerOrFailure = await _authRepository.signOut();
    return registerOrFailure.fold(
            (error) => Left(error),
            (ok) => Right(ok)
    );

  }

}