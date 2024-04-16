import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../../repositories.dart';
import '../../../fare/domain/use_cases/get_picked_fare_use_case.dart';
import '../../domain/use_cases/get_picked_origin_use_case.dart';
import '../../domain/use_cases/pick_origin_use_case.dart';

part 'location_selection_state.dart';

final pickLocationProvider = StateNotifierProvider.autoDispose<PickLocationNotifier,LocationSelectionState>(
        (ref) {
      // ref.onDispose(() => print('eeeey disposed'));
      return PickLocationNotifier(ref.read(Repositories.pickOriginUseCase),ref.read(Repositories.getOriginUseCase),ref.read(Repositories.getPickedFareUseCase))..init();
    }
);


class PickLocationNotifier extends StateNotifier<LocationSelectionState>{

  final PickOrigin _pickOrigin;
  final GetPickedOrigin _getOrigin;
  final GetPickedFare _fare;

  PickLocationNotifier(this._pickOrigin, this._getOrigin, this._fare) : super(const LocationSelectionNone());

  Future<void> pickLocation(LatLng location) async {
    final origin = _getOrigin();
    if(state is LocationSelectionNone){
      state = LocationSelectionOrigin(origin: location);
      _pickOrigin(location);
      return;
    }
    state = LocationSelectionDestination(origin: origin,destination: location);
  }

  Future<void> pickOrigin(LatLng location) async {
    state = LocationSelectionOrigin(origin: location);
    _pickOrigin(location);
  }

  void init() {
    _checkInitialOrigin();
  }

  void clearOrigin() {
    state = const LocationSelectionNone();
    _pickOrigin(null);
  }

  void restart() {
    final hasOrigin = _checkInitialOrigin();
    if(!hasOrigin){
      state = const LocationSelectionNone();
    }
  }

  bool _checkInitialOrigin() {
    final fare = _fare();
    final location = fare?.location;
    if(location != null){
      state = LocationSelectionOrigin(origin: location,canPickOrigin: false);
      _pickOrigin(location);
      return true;
    }

    return false;

  }

  void confirm() {
    state = LocationSelectionComplete(origin: state.origin, destination: state.destination);
  }

}