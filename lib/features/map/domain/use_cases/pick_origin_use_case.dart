import 'package:latlong2/latlong.dart';

import '../repositories/map_repository.dart';

class PickOrigin{
  final MapRepository _mapRepository;

  PickOrigin(this._mapRepository);

  void call(LatLng? location) => _mapRepository.pickLocation(location);
}