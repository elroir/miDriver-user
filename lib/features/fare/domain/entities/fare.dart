import 'package:latlong2/latlong.dart';
class Fare {

  final int id;
  final double price;
  final String title;
  final String description;
  final String imageUrl;
  final bool defaultFare;
  final LatLng? location;


  Fare({
    required this.id,
    required this.price,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.defaultFare,
    this.location
  });
}