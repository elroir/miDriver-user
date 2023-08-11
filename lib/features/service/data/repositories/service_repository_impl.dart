import 'dart:io';

import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error_messages.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/http/entities/http_response.dart';

import '../../../../core/network/network_info.dart';
import '../../domain/repositories/service_repository.dart';
import '../data_sources/service_remote_data_source.dart';
import '../models/service_form_model.dart';

class ServiceRepositoryImpl implements ServiceRepository{

  final ServiceRemoteDataSource _remoteDataSource;
  final NetworkInfoRepository _networkInfoRepository;

  ServiceRepositoryImpl(this._remoteDataSource, this._networkInfoRepository);

  @override
  Future<Either<Failure, HttpSuccess>> storeService(ServiceFormModel service) async {
    try{
      if(!await _networkInfoRepository.isConnected){
        return Left(SocketFailure());
      }

      final response = await _remoteDataSource.storeService(service);
      return Right(response);
    }on AuthenticationException{
      return Left(AuthFailure(errorMessage: ErrorMessages.sessionExpiredMessageError));
    }on ServerException{
      return Left(ServerFailure());
    }on SocketException{
      return Left(SocketFailure());
    }
  }
}