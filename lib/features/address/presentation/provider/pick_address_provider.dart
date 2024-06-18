import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../repositories.dart';
import '../../domain/use_cases/pick_address_id_use_case.dart';

final pickAddressesProvider = StateNotifierProvider<PickAddressNotifier,int>(
        (ref) => PickAddressNotifier(ref.read(Repositories.pickAddressIdUseCase))

);


class PickAddressNotifier extends StateNotifier<int> {

  final PickAddressId _pickAddressId;

  PickAddressNotifier(this._pickAddressId) : super(0);

  void pickAddressId(int addressId) {
    state = addressId;
    _pickAddressId(addressId);

  }

}