import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/http/entities/http_post_status.dart';
import '../../../../repositories.dart';
import '../../../fare/domain/use_cases/get_cached_fares_use_case.dart';

import '../../../fare/domain/use_cases/pick_fare_use_case.dart';
import '../../../map/domain/entities/direction.dart';
import '../../domain/use_cases/get_address_direction_use_case.dart';


final addressDirectionProvider = StateNotifierProvider.autoDispose<AddressDirectionNotifier,HttpPostStatus<(double,Direction)>>(
        (ref) {
      return AddressDirectionNotifier(
          ref.read(Repositories.getAddressDirectionUseCase),
          ref.read(Repositories.getCachedFaresUseCase),
          ref.read(Repositories.pickFareUseCase)
      )..getHomeDirections();
    }
);


class AddressDirectionNotifier extends StateNotifier<HttpPostStatus<(double,Direction)>>{

  final GetAddressDirection _getDirections;
  final GetCachedFares _getCachedFares;
  final PickFare _pickFare;

  AddressDirectionNotifier(this._getDirections,this._getCachedFares,this._pickFare) : super(HttpPostStatusNone());


  Future<void> getHomeDirections() async {
    state = HttpPostStatusLoading();
    final response = await _getDirections();
    response.fold(
            (error) => state = HttpPostStatusError(message: error.errorMessage),
            (direction) async {
              final cachedFares = await _getCachedFares();
             state = cachedFares.fold(
                      (error) => HttpPostStatusError(message: error.errorMessage),
                      (fares) {
                        final fare = fares.firstWhere((e) => e.defaultFare);
                        _pickFare(fare);
                        double price = fare.price * (direction.distanceInMeters/1000);
                        price = price<50 ? 50 : price;
                        return HttpPostStatusSuccess(data: (price,direction));
                      }
              );

            }
    );
  }

}