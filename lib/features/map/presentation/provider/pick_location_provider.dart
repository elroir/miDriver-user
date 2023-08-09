import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../../repositories.dart';
import '../../../service/presentation/provider/service_form_provider.dart';
import '../../domain/use_cases/get_picked_origin_use_case.dart';
import '../../domain/use_cases/pick_origin_use_case.dart';

part 'location_selection_state.dart';

final pickLocationProvider = StateNotifierProvider.autoDispose<PickLocationNotifier,LocationSelectionState>(
        (ref) {
      // ref.onDispose(() => print('eeeey disposed'));
      final fare = ref.read(serviceFormProvider.notifier).getFare();

      return PickLocationNotifier(ref.read(Repositories.pickOriginUseCase),ref.read(Repositories.getOriginUseCase))..init(fare?.location);
    }
);


class PickLocationNotifier extends StateNotifier<LocationSelectionState>{

  final PickOrigin _pickOrigin;
  final GetPickedOrigin _getOrigin;

  PickLocationNotifier(this._pickOrigin, this._getOrigin) : super(const LocationSelectionNone());

  Future<void> pickLocation(LatLng location) async {
    final origin = _getOrigin();
    if(state is LocationSelectionNone){
      state = LocationSelectionOrigin(origin: location);
      _pickOrigin(location);
      return;
    }
    state = LocationSelectionDestination(origin: origin,destination: location);
  }

  void init(LatLng? location) {
    if(location != null){
      state = LocationSelectionOrigin(origin: location,canPickOrigin: false);
      _pickOrigin(location);
    }
  }

  void confirm() {
    state = LocationSelectionComplete(origin: state.origin, destination: state.destination);
  }

}