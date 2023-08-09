import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/form/form_provider.dart';
import '../../../../core/http/entities/http_post_status.dart';
import '../../../../core/router/router.dart';
import '../../../fare/domain/entities/fare.dart';
import '../../../vehicle/domain/entities/user_vehicle.dart';



final serviceFormProvider = StateNotifierProvider.autoDispose<ServiceProvider,HttpPostStatus>(
        (ref) => ServiceProvider(ref.read(formProvider),ref.read(router))
);


class ServiceProvider extends StateNotifier<HttpPostStatus>{

  final GlobalKey<FormState> key;
  final GoRouter _router;

  ServiceProvider(this.key, this._router) : super(HttpPostStatusNone());

  Fare? _fare;
  UserVehicle? _vehicle;
  final TextEditingController vehicleController = TextEditingController();


  void pickFare(Fare? fare) {
    _fare = fare;

  }

  void pickVehicle(UserVehicle? vehicle){
    _vehicle = vehicle;
  }


  Fare? getFare(){
    return _fare;
  }


  Future<void> storeService() async {
    final FormState form = key.currentState!;
    if(!form.validate()) return;
    form.save();

  }

}