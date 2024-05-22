import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/http/entities/http_post_status.dart';
import '../../../../core/router/router.dart';
import '../../../../repositories.dart';
import '../../../address/domain/use_cases/get_default_address_use_case.dart';
import '../../../fare/domain/use_cases/get_picked_fare_use_case.dart';
import '../../../map/domain/use_cases/get_picked_origin_use_case.dart';
import '../../../vehicle/domain/entities/transport_type.dart';
import '../../data/models/service_form_model.dart';
import '../../domain/use_cases/store_service_use_case.dart';

final defaultServiceProvider = StateNotifierProvider.autoDispose<DefaultServiceProvider,HttpPostStatus>(
        (ref) {


          return DefaultServiceProvider(
            ref.read(Repositories.getPickedFareUseCase),
            ref.read(Repositories.getOriginUseCase),
            ref.read(Repositories.storeServiceUseCase),
            ref.read(Repositories.getDefaultAddressUseCase),
            ref.read(router)

          );
    }
);

class DefaultServiceProvider extends StateNotifier<HttpPostStatus>{

  final GetPickedFare _getPickedFare;
  final GetPickedOrigin _origin;
  final StoreService _storeService;
  final GetDefaultAddress _getDefaultAddress;
  final GoRouter _router;

  DefaultServiceProvider(this._getPickedFare,this._origin,this._storeService,this._getDefaultAddress,this._router) : super(HttpPostStatusNone());

  TransportType? _transportType;
  late double _price;
  late double _distanceInKm;
  
  void setTransportType(List<TransportType> transportTypes){
    _transportType = transportTypes.firstWhere((e) => e.defaultTransportType);
  }

  void setPriceAndDistance(double price,double distanceInMeters){
    _price = price;
    _distanceInKm = distanceInMeters / 1000;
  }

  Future<void> storeService() async {


    final date = DateTime.now();
    final fare = _getPickedFare();

    final addressOrFail = _getDefaultAddress();
    addressOrFail.fold(
            (error) => state =  HttpPostStatusError(message: error.errorMessage),
            (address) async {
                  final serviceForm = ServiceModel(
                  distanceInKm: _distanceInKm,
                  price: _price,
                  transportType: _transportType!,
                  fare: fare!,
                  origin: _origin()!,
                  destination: address.location,
                  serviceDateTime: date
              );
                  state = HttpPostStatusLoading();
                  final response = await _storeService(serviceForm);
                  state = response.fold(
                          (error) => HttpPostStatusError(message: error.errorMessage),
                          (success) {
                        _router.pop();
                        return HttpPostStatusSuccess();
                      }
                  );
            }
    );






  }

}
