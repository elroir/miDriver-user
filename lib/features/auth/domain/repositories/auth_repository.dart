import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/http/entities/http_response.dart';
import '../entities/auth_user.dart';
import '../entities/personal_data.dart';

abstract interface class AuthRepository{

  Future<Either<Failure, HttpSuccess>> signInWithEmail(AuthUser user);
  void initSignUpProcess(AuthUser user);
  void savePersonalData(PersonalData personalData);
  Either<Failure,AuthUser> get user;
  Future<Either<Failure, HttpSuccess>> signUp();
  Future<Either<Failure, HttpSuccess>> verifyEmail(String email);
  Future<Either<Failure, HttpSuccess>> verifyRole(String email);

  Future<Either<Failure, HttpSuccess>> requestPasswordRecovery(String email);
  Future<Either<Failure, HttpSuccess>> signOut();

}