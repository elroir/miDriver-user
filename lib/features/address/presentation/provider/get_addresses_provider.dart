import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../repositories.dart';
import '../../domain/entities/address.dart';
import '../../domain/use_cases/get_addresses_use_case.dart';

final getAddressesProvider = StateNotifierProvider<AddressNotifier,List<Address>>(
        (ref) => AddressNotifier(ref.read(Repositories.getAddressesUseCase))..getAddresses()

);


class AddressNotifier extends StateNotifier<List<Address>> {

  final GetAddresses _getAddresses;

  AddressNotifier(this._getAddresses) : super([]);

  Future<void> getAddresses() async {
    final result = await _getAddresses();
    result.fold(
            (failure) => throw failure,
            (addresses) {
              state = addresses;
            }
    );

  }

}