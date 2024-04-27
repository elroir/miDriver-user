import 'package:latlong2/latlong.dart';

class Address{
  final int id;
  final String userId;
  final String textual;
  final bool defaultAddress;
  final LatLng location;

  Address({this.id = 0, required this.userId, required this.textual, required this.defaultAddress, required this.location});


}
