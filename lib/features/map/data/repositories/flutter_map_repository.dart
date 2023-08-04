import 'package:latlong2/latlong.dart';

import '../../../../core/network/network_info.dart';
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



}