import 'dart:io';

import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error_messages.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/http/entities/http_response.dart';

import '../../../../core/network/network_info.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../data_sources/user_local_data_source.dart';
import '../data_sources/user_remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {

  final UserRemoteDataSource _remoteDataSource;
  final UserLocalDataSource _localDataSource;
  final NetworkInfoRepository _networkInfo;

  UserRepositoryImpl(this._remoteDataSource, this._localDataSource, this._networkInfo);

  @override
  Future<Either<Failure, HttpSuccess>> updatePushToken() async {
    try{
      final response = await _remoteDataSource.updatePushToken();
      return Right(response);
    }on AuthenticationException{
      return Left(AuthFailure(errorMessage: ErrorMessages.sessionExpiredMessageError));
    }on PushNotificationException{
      return Left(PushNotificationFailure());
    }on ServerException{
      return Left(ServerFailure());
    }on SocketException{
      return Left(SocketFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getUser() async {
    if(await _networkInfo.isConnected){
      try{
        final response = await _remoteDataSource.getUser();
        _localDataSource.cacheUser(response.data!);
        return Right(response.data!);
      }on AuthenticationException{
        return Left(AuthFailure(errorMessage: ErrorMessages.sessionExpiredMessageError));
      }on PushNotificationException{
        return Left(PushNotificationFailure());
      }on ServerException{
        return Left(ServerFailure());
      }
    }

    try{
      final user = await _localDataSource.getStoredUserData();
      return Right(user);
    }
    on CacheException {
      return Left(CacheFailure());
    }

  }


}