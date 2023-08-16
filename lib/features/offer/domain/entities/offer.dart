import '../../../user/domain/entities/user.dart';

class Offer{

  final int id;
  final User user;
  final double price;

  Offer({
    required this.id,
    required this.user,
    required this.price
  });
}