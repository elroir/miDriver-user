import 'dart:io';

import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error_messages.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/offer.dart';
import '../../domain/repositories/offer_repository.dart';
import '../data_sources/offer_remote_datasource.dart';

class OfferRepositoryImpl implements OfferRepository{

  final OfferRemoteDataSource _remoteDataSource;
  final NetworkInfoRepository _networkInfo;

  OfferRepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, List<Offer>>> getOffers(int serviceId) async {
    try{
      if(!await _networkInfo.isConnected){
        return Left(SocketFailure());
      }

      final response = await _remoteDataSource.getOffers(serviceId);
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