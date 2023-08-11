import '../../domain/entities/service_form.dart';

class ServiceFormModel extends ServiceForm{

  ServiceFormModel({
    required super.distanceInKm,
    required super.price,
    required super.fare,
    required super.car,
    required super.origin,
    required super.destination
  });


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