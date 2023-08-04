
import 'package:fpdart/fpdart.dart';

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

  @override
  Future<Either<Failure, List<Fare>>> getFares() async {
    if(!await _networkInfo.isConnected){
      return Left(ServerFailure());
    }

    try{
      final fares = await _remoteDataSource.getFares();
      return Right(fares);

    }on AuthenticationException{
      return Left(AuthFailure());
    }on ServerException{
      return Left(ServerFailure());
    }
  }

}