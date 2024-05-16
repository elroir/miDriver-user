import 'package:latlong2/latlong.dart';

import '../../../fare/data/models/fare_model.dart';
import '../../../vehicle/data/models/transport_type_model.dart';
import '../../../vehicle/domain/entities/transport_type.dart';
import '../../domain/entities/service.dart';

class ServiceModel extends Service{

  ServiceModel({
    super.id,
    required super.distanceInKm,
    required super.price,
    required super.fare,
    super.transportType = const TransportType.car(),
    required super.origin,
    required super.destination,
    required super.serviceDateTime,
    super.status
  });


  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      distanceInKm: json['total_distance']/1,
      price: json['total_price']/1,
      fare: FareModel.fromJson(json['fare']),
      // car: json['vehicle'] !=null ? UserVehicleModel.fromJson(json['vehicle']) : null,
      transportType: TransportTypeModel.fromJson(json['vehicle_type']),
      origin: LatLng(json['from']['coordinates'][1],json['from']['coordinates'][0]),
      destination: LatLng(json['to']['coordinates'][1],json['to']['coordinates'][0]),
      serviceDateTime: DateTime.parse(json['date']),
      status: stringToServiceStatus[json['status']] ?? ServiceStatus.published
    );
  }


  Map<String, dynamic> toJson(String userId) => {
    'client'              : userId,
    'vehicle_type'        : transportType.id,
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