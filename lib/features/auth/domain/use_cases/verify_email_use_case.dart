import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/http/entities/http_response.dart';
import '../repositories/auth_repository.dart';

class VerifyEmail{

  final AuthRepository _authRepository;

  VerifyEmail(this._authRepository);

  Future<Either<Failure,HttpSuccess>> call(String email) async {
    final verifyOrFailure = await _authRepository.verifyEmail(email);
    return verifyOrFailure.fold(
            (error) => Left(error),
            (ok) => Right(ok)
    );

  }

}