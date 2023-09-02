import 'package:latlong2/latlong.dart';

import '../../../../core/location/location_repository.dart';

class GetLocationStream{
  final LocationRepository _locationRepository;

  GetLocationStream(this._locationRepository);

  Stream<LatLng> call() {
    return _locationRepository.locationStream;
  }
}