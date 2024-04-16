import 'dart:io';

import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error_messages.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/http/entities/http_response.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/address.dart';

import '../../domain/repositories/address_repository.dart';
import '../data_sources/address_remote_datasource.dart';
import '../models/address_model.dart';

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

  @override
  Future<Either<Failure, HttpSuccess>> deleteAddress(int addressId) {
    // TODO: implement deleteAddress
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, HttpSuccess>> storeAddress(Address address) async {
    if(await _networkInfoRepository.isConnected){
      try{

        await _remoteDataSource.storeAddress(AddressModel.fromEntity(address));
        return Right(HttpSuccess());
      }on AuthenticationException{
        return Left(AuthFailure(errorMessage: ErrorMessages.sessionExpiredMessageError));
      }on ServerException{
        return Left(ServerFailure());
      }on SocketException{
        return Left(SocketFailure());
      }
    }
    return Left(SocketFailure());
  }

}