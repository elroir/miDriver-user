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

  List<Address> _addresses = [];

  @override
  Future<Either<Failure, List<Address>>> getAddresses() async {
    try{
      if(!await _networkInfoRepository.isConnected){
        return Left(SocketFailure());
      }

      final response = await _remoteDataSource.getAddresses();
      _addresses = response;
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
  Future<Either<Failure, HttpSuccess>> deleteAddress(int addressId) async {
    if(await _networkInfoRepository.isConnected){
      try{

        await _remoteDataSource.deleteAddress(addressId);
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

  @override
  Future<Either<Failure, HttpSuccess>> storeOrEditAddress(Address address) async {
    if(await _networkInfoRepository.isConnected){
      try{
        if(address.id!=0){
          await _remoteDataSource.editAddress(AddressModel.fromEntity(address));
          return Right(HttpSuccess());
        }

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

  @override
  Either<Failure,Address> getAddressById(int addressId) {
    if(_addresses.any((e) => e.id==addressId)){
      return Right(_addresses.firstWhere((e) => e.id==addressId));
    }
    return Left(CacheFailure());

  }

}