import 'dart:io';

import 'package:fpdart/fpdart.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/term.dart';
import '../../domain/repositories/terms_repository.dart';
import '../data_sources/terms_remote_datasource.dart';

class TermsRepositoryImpl implements TermsRepository {
  final TermsRemoteDataSource _remoteDataSource;
  final NetworkInfoRepository _networkInfoRepository;

  TermsRepositoryImpl(this._remoteDataSource, this._networkInfoRepository);


  @override
  Future<Either<Failure, Term>> getTermsAndConditions() async {
    try {
      if(!await _networkInfoRepository.isConnected){
        return Left(SocketFailure());
      }
      final terms = await _remoteDataSource.getTermsAndConditions();
      return Right(terms);
    } on ServerException {
      return Left(ServerFailure());
    }on SocketException{
      return Left(SocketFailure());
    }
  }
}