import 'package:latlong2/latlong.dart';

import '../../domain/entities/address.dart';

class AddressModel extends Address{
  AddressModel({required super.id, required super.userId,required super.title, required super.address,required super.defaultAddress, required super.location});

  factory AddressModel.fromJson(Map<String,dynamic> json){
    return AddressModel(
        id: json['id'],
        userId: json['user'],
        title: json['name'],
        address: json['address'],
        defaultAddress: json['default'] ?? false,
        location: LatLng(json['location']['coordinates'][1],json['location']['coordinates'][0])
    );
  }

  factory AddressModel.fromEntity(Address address) =>
      AddressModel(
          id: address.id,
          userId: address.userId,
          title: address.title,
          address: address.address,
          defaultAddress: address.defaultAddress,
          location: address.location
      );

  Map<String,dynamic> toJson(){
    return {
      'name'    : title,
      'address' : address,
      'default' : defaultAddress,
      'user' : userId,
      'location' : {
        'type' : 'Point',
        'coordinates' : [location.longitude,location.latitude]
      }
    };
  }
}