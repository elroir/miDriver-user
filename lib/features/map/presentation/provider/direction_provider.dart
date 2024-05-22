import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/http/entities/http_post_status.dart';
import '../../../../repositories.dart';
import '../../domain/entities/direction.dart';
import '../../domain/use_cases/get_directions_use_case.dart';

final directionProvider = StateNotifierProvider<DirectionNotifier,HttpPostStatus<Direction>>(
        (ref) {
      return DirectionNotifier(ref.read(Repositories.getDirectionsUseCase));
    }
);


class DirectionNotifier extends StateNotifier<HttpPostStatus<Direction>>{

  final GetDirections _getDirections;

  DirectionNotifier(this._getDirections) : super(HttpPostStatusNone());

  Future<void> getDirections(LatLng destination) async {
    state = HttpPostStatusLoading();
    final response = await _getDirections(destination);
    state = response.fold(
            (error) => HttpPostStatusError(message: error.errorMessage),
            (directions) => HttpPostStatusSuccess(data: directions)
    );
  }

}