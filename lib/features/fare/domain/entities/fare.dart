import 'package:latlong2/latlong.dart';
class Fare {

  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final LatLng? location;


  Fare({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.location
  });
}