import 'package:latlong2/latlong.dart';

import '../../../fare/data/models/fare_model.dart';
import '../../../vehicle/data/models/user_vehicle_model.dart';
import '../../domain/entities/service.dart';

class ServiceModel extends Service{

  ServiceModel({
    super.id,
    required super.distanceInKm,
    required super.price,
    required super.fare,
    required super.car,
    required super.origin,
    required super.destination,
    required super.serviceDateTime,
    super.status
  });


  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      distanceInKm: json['total_distance'],
      price: json['total_price']/1,
      fare: FareModel.fromJson(json['fare']),
      car: UserVehicleModel.fromJson(json['vehicle']),
      origin: LatLng(json['from']['coordinates'][1],json['from']['coordinates'][0]),
      destination: LatLng(json['to']['coordinates'][1],json['to']['coordinates'][0]),
      serviceDateTime: DateTime.parse(json['date']),
      status: stringToServiceStatus[json['status']] ?? ServiceStatus.published
    );
  }


  Map<String, dynamic> toJson(String userId) => {
    'client'              : userId,
    'vehicle'             : car!.id,
    'fare'                : fare.id,
    'total_price'         : price,
    'total_distance'      : distanceInKm,
    'date'                : serviceDateTime.toIso8601String(),
    'from'                : {
                              'type': 'Point',
                              'coordinates': [
                                  origin.longitude,
                                  origin.latitude
                                      ]
                              },
    'to'                  : {
                              'type': 'Point',
                              'coordinates': [
                                  destination.longitude,
                                  destination.latitude
                                      ]
                              },
  };


}

Map<String,ServiceStatus> stringToServiceStatus = {
  'published' : ServiceStatus.published,
  'accepted' : ServiceStatus.accepted,
  'in_progress' : ServiceStatus.inProgress,
  'finished' : ServiceStatus.finished,
  'paid' : ServiceStatus.paid,
  'cancelled' : ServiceStatus.cancelled,
};