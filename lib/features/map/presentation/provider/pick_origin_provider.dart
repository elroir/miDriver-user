import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../../repositories.dart';
import '../../domain/use_cases/pick_origin_use_case.dart';


final pickOriginProvider = StateNotifierProvider.autoDispose<PickOriginNotifier,LatLng?>(
        (ref) {
          return PickOriginNotifier(ref.read(Repositories.pickOriginUseCase));
        }
);


class PickOriginNotifier extends StateNotifier<LatLng?>{

  final PickOrigin _pickOrigin;

  PickOriginNotifier(this._pickOrigin) : super(null);

  Future<void> pickOrigin(LatLng position) async {
    state = position;
    _pickOrigin(position);
  }

}