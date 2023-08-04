import '../../../../core/http/http_options.dart';
import '../../domain/entities/fare.dart';

class FareModel extends Fare {

  FareModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imageUrl
  });

  factory FareModel.fromJson(Map<String,dynamic> json) => FareModel(
      id: json['id'],
      title: json['name'],
      description: json['description'],
      imageUrl: 'https://${HttpOptions.apiUrl}/assets/${json['icon']}'
  );

}