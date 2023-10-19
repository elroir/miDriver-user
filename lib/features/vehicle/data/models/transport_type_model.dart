import '../../../../core/http/http_options.dart';
import '../../domain/entities/transport_type.dart';

class TransportTypeModel extends TransportType{
  TransportTypeModel({required super.id, required super.name, required super.imageUrl});

  factory TransportTypeModel.fromJson(Map<String,dynamic> json) => TransportTypeModel(
    id: json['id'],
    name: json['name'],
    imageUrl: 'https://${HttpOptions.apiUrl}/assets/${json['icon']}'
  );
}