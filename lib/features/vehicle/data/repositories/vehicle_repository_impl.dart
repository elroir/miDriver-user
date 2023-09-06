

import 'dart:io';

import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error_messages.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/http/entities/http_response.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../domain/entities/car_make.dart';
import '../../domain/entities/user_vehicle.dart';
import '../../domain/repositories/vehicle_repository.dart';
import '../data_sources/vehicle_remote_datasource.dart';
import '../models/user_vehicle_model.dart';

class VehicleRepositoryImpl implements VehicleRepository{

  final VehicleRemoteDataSource _remoteDataSource;
  final NetworkInfoRepository _networkInfo;

  VehicleRepositoryImpl(this._remoteDataSource,this._networkInfo);

  String _transmissionType = AppStrings.automatic;
  int? _makeId;


  @override
  Future<Either<Failure, List<CarMake>>> getCarMakes() async {
    if(await _networkInfo.isConnected){
      try{
        final response = await _remoteDataSource.getCarMakes();
        return Right(response.data!);
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
  Future<Either<Failure, HttpSuccess>> storeVehicle(UserVehicle vehicle,String userId) async {
    if(await _networkInfo.isConnected){
      try{

        if(_makeId==null){
          return Left(ValidationFailure(errorMessage: ErrorMessages.noMakeSelected));
        }

        final response = await _remoteDataSource.storeVehicle(UserVehicleModel.fromEntity(vehicle,userId,_makeId!,_toTransmissionStatus()));
        return Right(response);
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
  Future<Either<Failure, List<UserVehicle>>> getUserVehicles() async {

    try{
      final response = await _remoteDataSource.getUserVehicles();
      return Right(response.data!);
    }on AuthenticationException{
      return Left(AuthFailure(errorMessage: ErrorMessages.sessionExpiredMessageError));
    }on ServerException{
      return Left(ServerFailure());
    }on SocketException{
      return Left(SocketFailure());
    }

  }

  String _toTransmissionStatus(){
    if(_transmissionType==AppStrings.automatic){
      return 'automatic';
    }
    return 'manual';
  }

  @override
  void saveTransmissionType(String transmissionType) {
    _transmissionType = transmissionType;
  }

  @override
  void saveMakeId(int makeId) {
    _makeId = makeId;
  }

  @override
  Future<Either<Failure, HttpSuccess>> deleteVehicle(int vehicleId) async {
    if(await _networkInfo.isConnected){
      try{

        final response = await _remoteDataSource.deleteVehicle(vehicleId);
        return Right(response);
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