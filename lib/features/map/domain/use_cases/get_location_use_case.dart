import 'package:fpdart/fpdart.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/location/location_repository.dart';

class GetLocation{

  final LocationRepository _locationRepository;

  GetLocation(this._locationRepository);

  Future<Either<Failure,LatLng>> call() async {
    final permissionOrFailure = await _locationRepository.requestLocationPermission();
    return permissionOrFailure.fold(
      (error) => Left(error),
      (ok) async {
        final position = await _locationRepository.getLocation();

        return Right(position);
      }
    );
  }
}