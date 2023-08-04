import '../../domain/entities/direction.dart';

class DirectionModel extends Direction{
  DirectionModel({required super.duration, required super.distanceInMeters, required super.geometry});

  factory DirectionModel.fromJson(Map<String, dynamic> json) {
    return DirectionModel(
      duration: json['routes'][0]['duration'],
      distanceInMeters: json['routes'][0]['distance'],
      geometry: json['routes'][0]['geometry']
    );
  }

}