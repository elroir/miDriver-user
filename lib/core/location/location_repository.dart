
import 'package:fpdart/fpdart.dart';
import 'package:latlong2/latlong.dart';

import '../error/failures.dart';

abstract interface class LocationRepository{

  Future<bool> get hasPermission;

  Future<LatLng> getLocation();

  Stream<LatLng> get locationStream;


  Future<Either<Failure,bool>> requestLocationPermission();


}