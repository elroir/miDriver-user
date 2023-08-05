import 'package:fpdart/fpdart.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/error/error_messages.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/direction.dart';
import '../../domain/repositories/map_repository.dart';
import '../data_sources/map_remote_datasource.dart';

class MapRepositoryImpl implements MapRepository{
  LatLng? _pickedOrigin;

  final MapRemoteDataSource _remoteDataSource;
  final NetworkInfoRepository _networkInfoRepository;

  MapRepositoryImpl(this._remoteDataSource, this._networkInfoRepository);


  @override
  void pickLocation(LatLng position) {
    _pickedOrigin = position;
  }

  @override
  LatLng? get origin => _pickedOrigin;

  @override
  Future<Either<Failure, Direction>> getDirections(LatLng destination) async {
    if(_pickedOrigin==null){
      return Left(ValidationFailure(errorMessage: ErrorMessages.originNotSelected));
    }
    if(!await _networkInfoRepository.isConnected){
      return Left(SocketFailure());
    }
    try{
      final directions = await _remoteDataSource.getDirections(_pickedOrigin!, destination);
      return Right(directions);
    }on ServerException{
      return Left(ServerFailure());
    }
  }



}