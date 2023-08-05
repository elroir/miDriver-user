import 'package:fpdart/fpdart.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/error/failures.dart';
import '../entities/direction.dart';
import '../repositories/map_repository.dart';

class GetDirections {

  final MapRepository _mapRepository;

  GetDirections(this._mapRepository);

  Future<Either<Failure,Direction>> call(LatLng destination) async {
    final directionsOrFailure = await _mapRepository.getDirections(destination);
    return directionsOrFailure;
  }
}