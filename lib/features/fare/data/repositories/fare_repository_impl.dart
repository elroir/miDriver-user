
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error_messages.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/fare.dart';


import '../../domain/repositories/fare_repository.dart';
import '../data_sources/fare_remote_datasource.dart';

class FareRepositoryImpl implements FareRepository{

  final FareRemoteDataSource _remoteDataSource;
  final NetworkInfoRepository _networkInfo;

  FareRepositoryImpl(this._remoteDataSource, this._networkInfo);

  List<Fare> _cachedFares = [];
  Fare? _pickedFare;

  @override
  Future<Either<Failure, List<Fare>>> getFares() async {
    if(!await _networkInfo.isConnected){
      return Left(ServerFailure(errorMessage: ErrorMessages.noInternetMessageError));
    }

    try{
      final fares = await _remoteDataSource.getFares();
      _cachedFares = fares;
      return Right(fares);

    }on AuthenticationException{
      return Left(AuthFailure());
    }on ServerException{
      return Left(ServerFailure());
    }
  }

  @override
  Either<Failure, List<Fare>> getCachedFares() {
   if(_cachedFares.isNotEmpty){
     return Right(_cachedFares);
   }else{
     return Left(CacheFailure());
   }
  }

  @override
  void pickFare(Fare? fare) {
    _pickedFare = fare;
  }

  @override
  Fare? get pickedFare => _pickedFare;

}