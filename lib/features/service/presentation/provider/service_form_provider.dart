import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/form/form_provider.dart';
import '../../../../core/http/entities/http_post_status.dart';
import '../../../../core/router/router.dart';
import '../../../../repositories.dart';
import '../../../fare/domain/use_cases/get_picked_fare_use_case.dart';
import '../../../map/domain/use_cases/get_picked_origin_use_case.dart';
import '../../../vehicle/domain/entities/user_vehicle.dart';
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

  UserVehicle? _vehicle;
  LatLng? _destination;
  final TextEditingController vehicleController = TextEditingController();
  double distanceInKm = 0;
  double price = 50;

  void pickVehicle(UserVehicle? vehicle){
    _vehicle = vehicle;
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

    final serviceForm = ServiceModel(
        distanceInKm: distanceInKm,
        price: price,
        car: _vehicle,
        fare: _fare()!,
        origin: _origin()!,
        destination: _destination!
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