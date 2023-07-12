import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/form/form_provider.dart';
import '../../../../core/form/form_validators.dart';
import '../../../../core/http/entities/http_post_status.dart';
import '../../../../core/router/router.dart';
import '../../../../repositories.dart';
import '../../domain/entities/user_vehicle.dart';
import '../../domain/use_cases/store_vehicle_use_case.dart';


final vehicleProvider = StateNotifierProvider<VehicleProvider,HttpPostStatus>(
        (ref) => VehicleProvider(ref.read(formProvider),ref.read(router),ref.read(Repositories.storeVehicleUseCase))
);


class VehicleProvider extends StateNotifier<HttpPostStatus>{

  final GlobalKey<FormState> key;
  final GoRouter _router;
  final StoreVehicle _storeVehicle;

  VehicleProvider(this.key, this._router,this._storeVehicle) : super(HttpPostStatusNone());

  String _model = '';
  String _plate = '';
  int _year = 0;


  void saveModelField(String? value){
    _model = value ?? '';
  }

  void saveYearField(String? value){
    _year = int.parse(value ?? '0');
  }

  void savePlateField(String? value){
    _plate = value ?? '';
  }

  String? validateModel(String? value){
    return FormValidators.validateNotShorter(value,length: 1);
  }

  String? validatePlate(String? value){
    return FormValidators.validateNotShorter(value,length: 5);
  }

  String? validateYear(String? value){

    return FormValidators.validateInt(value,greaterThan: 1920,lowerThan: DateTime.now().year+1);
  }


  Future<void> storeVehicle() async {
    final FormState form = key.currentState!;
    if(!form.validate()) return;
    form.save();

    final vehicle = UserVehicle(
        model: _model,
        year: _year,
        plate: _plate.toUpperCase(),
    );

    state = HttpPostStatusLoading();

    final response = await _storeVehicle(vehicle);
    response.fold(
            (error) {
              state = HttpPostStatusError(message: error.errorMessage);

            },
            (r) {
              state = HttpPostStatusSuccess();
              _router.pop();
            }

    );

  }

}