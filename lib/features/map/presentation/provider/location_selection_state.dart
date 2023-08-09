
part of 'pick_location_provider.dart';
abstract class LocationSelectionState{
  final LatLng? origin;
  final LatLng? destination;
  final bool canPickOrigin;
  const LocationSelectionState({this.origin,this.destination,this.canPickOrigin = true});
}

class LocationSelectionNone extends LocationSelectionState{
  const LocationSelectionNone();
}

class LocationSelectionOrigin extends LocationSelectionState{
  const LocationSelectionOrigin({required super.origin,super.canPickOrigin});
}

class LocationSelectionDestination extends LocationSelectionState{
  const LocationSelectionDestination({required super.origin,required super.destination});
}

class LocationSelectionComplete extends LocationSelectionState{
  const LocationSelectionComplete({required super.origin,required super.destination});
}