import 'package:fpdart/fpdart.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/error/failures.dart';
import '../entities/direction.dart';

abstract interface class MapRepository{
  LatLng? get origin;
  void pickLocation(LatLng? position);
  Future<Either<Failure,Direction>> getDirections(LatLng destination);
}