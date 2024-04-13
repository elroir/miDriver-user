import 'dart:io';

import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error_messages.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/address.dart';

import '../../domain/repositories/address_repository.dart';
import '../data_sources/address_remote_datasource.dart';

class AddressRepositoryImpl implements AddressRepository{
  final AddressRemoteDataSource _remoteDataSource;
  final NetworkInfoRepository _networkInfoRepository;

  AddressRepositoryImpl(this._remoteDataSource, this._networkInfoRepository);

  @override
  Future<Either<Failure, List<Address>>> getAddresses() async {
    try{
      if(!await _networkInfoRepository.isConnected){
        return Left(SocketFailure());
      }

      final response = await _remoteDataSource.getAddresses();
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