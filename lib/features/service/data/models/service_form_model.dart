import 'package:latlong2/latlong.dart';

import '../../../fare/data/models/fare_model.dart';
import '../../../vehicle/data/models/user_vehicle_model.dart';
import '../../domain/entities/service.dart';

class ServiceModel extends Service{

  ServiceModel({
    required super.distanceInKm,
    required super.price,
    required super.fare,
    required super.car,
    required super.origin,
    required super.destination
  });


  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      distanceInKm: json['total_distance'],
      price: json['total_price']/1,
      fare: FareModel.fromJson(json['fare']),
      car: UserVehicleModel.fromJson(json['vehicle']),
      origin: LatLng(json['from']['coordinates'][1],json['from']['coordinates'][0]),
      destination: LatLng(json['to']['coordinates'][1],json['to']['coordinates'][0]),
    );
  }


  Map<String, dynamic> toJson(String userId) => {
    'client'              : userId,
    'vehicle'             : car!.id,
    'fare'                : fare.id,
    'total_price'         : price,
    'total_distance'      : distanceInKm,
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