import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/form/form_provider.dart';
import '../../../../core/form/form_validators.dart';
import '../../../../core/http/entities/http_post_status.dart';
import '../../../../core/router/router.dart';
import '../../../../repositories.dart';
import '../../../map/domain/use_cases/get_picked_origin_use_case.dart';
import '../../../map/domain/use_cases/pick_origin_use_case.dart';
import '../../domain/use_cases/get_address_use_case.dart';
import '../../domain/use_cases/store_address_use_case.dart';

final storeAddressProvider = StateNotifierProvider.autoDispose<StoreAddressProvider,HttpPostStatus>(
        (ref) => StoreAddressProvider(ref.read(formProvider),ref.read(router),ref.read(Repositories.storeOrEditAddressUseCase),ref.read(Repositories.getAddressUseCase),ref.read(Repositories.getOriginUseCase),ref.read(Repositories.pickOriginUseCase)
));

final storeAddressSwitchProvider = StateProvider.autoDispose<bool>((ref) {
 final state = ref.read(storeAddressProvider.notifier).defaultAddress;
  return state;
}
);

class StoreAddressProvider extends StateNotifier<HttpPostStatus>{

  final GlobalKey<FormState> key;
  final GoRouter _router;
  final StoreOrEditAddress _storeOrEditAddress;
  final GetAddress _getAddress;
  final GetPickedOrigin _getOrigin;
  final PickOrigin _pickOrigin;

  StoreAddressProvider(this.key, this._router,this._storeOrEditAddress,this._getAddress,this._getOrigin,this._pickOrigin) : super(HttpPostStatusNone());

  String title = '';
  String address = '';
  bool defaultAddress = true;
  bool isEditing = false;
  bool canChangeDefaultAddress = true;
  int addressId = 0;

  void getInitialAddress(int id){
    final addressOrFail = _getAddress(id);
    addressOrFail.fold(
            (error) {
          state = HttpPostStatusError(message: error.errorMessage);
        },
            (address) {
              _pickOrigin(address.location);
              isEditing = true;
              addressId = address.id;
              title = address.title;
              this.address = address.address;
              canChangeDefaultAddress = !address.defaultAddress;
          defaultAddress = address.defaultAddress;
        }
    );
  }

  void saveTitleField(String? value){
    title = value ?? '';
  }

  void saveAddressField(String? value){
    address = value ?? '';
  }

  String? validateTitle(String? value){
    return FormValidators.validateNotShorter(value,length: 2);
  }

  String? validateAddress(String? value){
    return FormValidators.validateNotShorter(value,length: 4);
  }

  void saveDefaultAddressField(bool value){
    defaultAddress = value;
  }

  Future<void> storeOrEditAddress() async {
    final FormState form = key.currentState!;
    if(!form.validate()) return;
    form.save();
    final location = _getOrigin();
    if(location == null){
      state = HttpPostStatusError(message: 'No seleccionó una ubicación en el mapa');
      return;
    }

    state = HttpPostStatusLoading();

    final response = await _storeOrEditAddress(
      id: addressId,
      title: title,
      address: address,
      location: location,
      defaultAddress: defaultAddress
    );
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

