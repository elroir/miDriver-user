import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/http/entities/http_response.dart';
import '../repositories/auth_repository.dart';

class RequestPasswordRecovery{

  final AuthRepository _authRepository;

  RequestPasswordRecovery(this._authRepository);

  Future<Either<Failure,HttpSuccess>> call(String email) async {
    final recoverOrFailure = await _authRepository.requestPasswordRecovery(email);
    return recoverOrFailure.fold(
            (error) => Left(error),
            (ok) => Right(ok)
    );

  }

}