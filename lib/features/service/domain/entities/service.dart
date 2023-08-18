import 'package:latlong2/latlong.dart';

import '../../../fare/domain/entities/fare.dart';
import '../../../vehicle/domain/entities/user_vehicle.dart';


enum ServiceStatus{
  published,
  accepted,
  inProgress,
  finished,
  paid,
  cancelled
}

class Service{
  final int id;
  final double distanceInKm;
  final double price;
  final LatLng origin;
  final LatLng destination;
  final UserVehicle? car;
  final Fare fare;
  final DateTime serviceDateTime;
  final ServiceStatus status;

  Service({
    this.id = 0,
    required this.distanceInKm,
    required this.price,
    required this.origin,
    required this.destination,
    this.car,
    required this.fare,
    required this.serviceDateTime,
    this.status = ServiceStatus.published
  });


}