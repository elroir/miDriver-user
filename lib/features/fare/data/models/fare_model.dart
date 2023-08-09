import 'package:latlong2/latlong.dart';

import '../../../../core/http/http_options.dart';
import '../../domain/entities/fare.dart';

class FareModel extends Fare {

  FareModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imageUrl,
    super.location
  });

  factory FareModel.fromJson(Map<String,dynamic> json) => FareModel(
      id: json['id'],
      title: json['name'],
      description: json['description'],
    imageUrl: json['icon'] != null ? 'https://${HttpOptions.apiUrl}/assets/${json['icon']}' : 'https://admin.midriverdesignado.com/assets/54552e90-b59f-46b0-8c7d-073b1b17e898',
    location: json['location']!= null ? LatLng(json['location']['coordinates'][1],json['location']['coordinates'][0]) : null
  );

}