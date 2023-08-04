import 'package:latlong2/latlong.dart';

import '../repositories/map_repository.dart';

class GetPickedOrigin{
  final MapRepository _mapRepository;

  GetPickedOrigin(this._mapRepository);


  LatLng? call() => _mapRepository.origin;
}