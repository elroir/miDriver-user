import '../../../user/data/models/user_model.dart';
import '../../domain/entities/offer.dart';

class OfferModel extends Offer{

  OfferModel({required super.id, required super.user, required super.price});

  factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
    id: json['id'],
    user: UserModel.fromJson(json['driver']),
    price: json['price']/1
  );

}