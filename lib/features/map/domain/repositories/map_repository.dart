
 import 'package:latlong2/latlong.dart';

enum LocationType{
  origin,
  destination
}

abstract interface class MapRepository{
  LatLng? get origin;
  void pickLocation(LatLng position);
}