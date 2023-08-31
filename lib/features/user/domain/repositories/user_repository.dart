import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/http/entities/http_response.dart';
import '../entities/user.dart';

abstract interface class UserRepository {

  Future<Either<Failure,HttpSuccess>> updatePushToken();
  Future<Either<Failure,User>> getUser();
  Future<Either<Failure,HttpSuccess>> deleteUser();

}