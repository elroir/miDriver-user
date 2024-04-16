import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/form/form_provider.dart';
import '../../../../core/form/form_validators.dart';
import '../../../../core/http/entities/http_post_status.dart';
import '../../../../core/router/router.dart';
import '../../../../repositories.dart';
import '../../../map/domain/use_cases/get_picked_origin_use_case.dart';
import '../../domain/use_cases/store_address_use_case.dart';

final storeAddressProvider = StateNotifierProvider.autoDispose<StoreAddressProvider,HttpPostStatus>(
        (ref) => StoreAddressProvider(ref.read(formProvider),ref.read(router),ref.read(Repositories.storeAddressUseCase),ref.read(Repositories.getOriginUseCase))
);

final storeAddressSwitchProvider = StateProvider.autoDispose<bool>((ref) {
 final state = ref.watch(storeAddressProvider.notifier).defaultAddress;
  return state;
}
);

class StoreAddressProvider extends StateNotifier<HttpPostStatus>{

  final GlobalKey<FormState> key;
  final GoRouter _router;
  final StoreAddress _storeAddress;
  final GetPickedOrigin _getOrigin;

  StoreAddressProvider(this.key, this._router,this._storeAddress,this._getOrigin) : super(HttpPostStatusNone());

  String _address = '';
  bool defaultAddress = true;

  void saveAddressField(String? value){
    _address = value ?? '';
  }

  String? validateAddress(String? value){
    return FormValidators.validateNotShorter(value,length: 4);
  }

  void saveDefaultAddressField(bool value){
    defaultAddress = value;
  }

  Future<void> storeAddress() async {
    final FormState form = key.currentState!;
    if(!form.validate()) return;
    form.save();
    final location = _getOrigin();
    if(location == null){
      state = HttpPostStatusError(message: 'No seleccionó una ubicación en el mapa');
      return;
    }

    state = HttpPostStatusLoading();

    final response = await _storeAddress(
      address: _address,
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

