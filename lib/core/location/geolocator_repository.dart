
import 'package:fpdart/fpdart.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../error/failures.dart';
import 'location_repository.dart';

class GeolocatorRepository implements LocationRepository{

  @override
  Future<LatLng> getLocation() async {

    final position = await Geolocator.getCurrentPosition();

    LatLng latLng = LatLng(position.latitude,position.longitude);

    return latLng;

  }

  @override
  Future<bool> get hasPermission => Geolocator.isLocationServiceEnabled();

  @override
  Future<Either<Failure, bool>> requestLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {

      return Left(LocationServicesFailure());
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.deniedForever) {

      return Left(LocationPermissionFailure());
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Left(LocationPermissionFailure());
      }
    }


    return const Right(true);
  }

  @override
  Stream<LatLng> get locationStream => Geolocator.getPositionStream().map((event) => LatLng(event.latitude, event.longitude));



}