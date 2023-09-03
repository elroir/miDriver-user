import '../../../user/data/models/user_model.dart';
import '../../domain/entities/offer.dart';

class OfferModel extends Offer{

  OfferModel({required super.id, required super.user, required super.price, super.distance,required super.status});

  factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
    id: json['id'],
    user: UserModel.fromJson(json['driver']),
    price: json['price']/1,
    distance: json['distance']!=null ? json['distance']/1 : null,
    status: json['status']
  );

}