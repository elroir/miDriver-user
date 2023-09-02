import '../../../user/domain/entities/user.dart';

class Offer{

  final int id;
  final User user;
  final double price;
  final double? distance;
  final String status;

  Offer({
    required this.id,
    required this.user,
    required this.price,
    this.distance,
    required this.status
  });
}