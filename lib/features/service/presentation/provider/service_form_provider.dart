import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/extension/date_time_extension.dart';
import '../../../../core/form/form_provider.dart';
import '../../../../core/http/entities/http_post_status.dart';
import '../../../../core/router/router.dart';
import '../../../../repositories.dart';
import '../../../fare/domain/use_cases/get_picked_fare_use_case.dart';
import '../../../map/domain/use_cases/get_picked_origin_use_case.dart';
import '../../../vehicle/domain/entities/transport_type.dart';
import '../../data/models/service_form_model.dart';
import '../../domain/use_cases/store_service_use_case.dart';



final serviceFormProvider = StateNotifierProvider<ServiceProvider,HttpPostStatus>(
        (ref) {
          return ServiceProvider(
              ref.read(formProvider),
              ref.read(Repositories.getPickedFareUseCase),
              ref.read(Repositories.getOriginUseCase),
              ref.read(Repositories.storeServiceUseCase),
              ref.read(router)
          );
        }
);


class ServiceProvider extends StateNotifier<HttpPostStatus>{

  final GlobalKey<FormState> key;
  final GetPickedFare _fare;
  final GetPickedOrigin _origin;
  final StoreService _storeService;

  final GoRouter _router;

  ServiceProvider(this.key,this._fare,this._origin,this._storeService ,this._router) : super(HttpPostStatusNone());

  TransportType? _transportType;
  LatLng? _destination;
  final TextEditingController vehicleController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  double distanceInKm = 0;
  double price = 50;

  void pickTransportType(TransportType? transportType){
    _transportType = transportType;
  }


  void fillDistanceAndPrice(double distanceInMeters,LatLng? destination){
    distanceInKm = distanceInMeters / 1000;
    _destination = destination;
    final totalPrice = _fare()!.price * distanceInKm;
    if(totalPrice>50){
      price = totalPrice;
    }


  }


  Future<void> storeService() async {
    final FormState form = key.currentState!;
    if(!form.validate()) return;
    form.save();

    if(_destination==null){
      return;
    }

    final date = DateTime.now().toDateTimeFromDateAndTimeString(dateController.text, timeController.text);

    final serviceForm = ServiceModel(
        distanceInKm: distanceInKm,
        price: price,
        transportType: _transportType!,
        fare: _fare()!,
        origin: _origin()!,
        destination: _destination!,
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

}