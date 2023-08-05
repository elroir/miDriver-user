
part of 'pick_location_provider.dart';
abstract class LocationSelectionState{
  final LatLng? origin;
  final LatLng? destination;
  const LocationSelectionState({this.origin,this.destination});
}

class LocationSelectionNone extends LocationSelectionState{
  const LocationSelectionNone();
}

class LocationSelectionOrigin extends LocationSelectionState{
  const LocationSelectionOrigin({required super.origin});
}

class LocationSelectionDestination extends LocationSelectionState{
  const LocationSelectionDestination({required super.origin,required super.destination});
}