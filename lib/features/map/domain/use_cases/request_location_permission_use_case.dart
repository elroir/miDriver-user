import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/location/location_repository.dart';

class RequestLocationPermission{
  final LocationRepository _locationRepository;

  RequestLocationPermission(this._locationRepository);

  Future<Either<Failure,bool>> call() async {
    final permissionOrFailure = await _locationRepository.requestLocationPermission();
    return permissionOrFailure;
  }
}