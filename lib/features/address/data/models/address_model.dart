import 'package:latlong2/latlong.dart';

import '../../domain/entities/address.dart';

class AddressModel extends Address{
  AddressModel({required super.id, required super.userId, required super.textual, required super.location});

  factory AddressModel.fromJson(Map<String,dynamic> json){
    return AddressModel(
      id: json['id'],
      userId: json['user'],
      textual: json['address'],
      location: LatLng(json['location']['coordinates'][0],json['location']['coordinates'][1])
    );
  }
}