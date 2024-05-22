import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/http/entities/http_post_status.dart';
import '../../../../repositories.dart';
import '../../domain/entities/address.dart';
import '../../domain/use_cases/get_addresses_use_case.dart';

final getAddressesProvider = StateNotifierProvider<AddressNotifier,HttpPostStatus<List<Address>>>(
        (ref) => AddressNotifier(ref.read(Repositories.getAddressesUseCase))..getAddresses()

);


class AddressNotifier extends StateNotifier<HttpPostStatus<List<Address>>> {

  final GetAddresses _getAddresses;

  AddressNotifier(this._getAddresses) : super(HttpPostStatusNone());

  Future<void> getAddresses() async {
    final result = await _getAddresses();
    state = result.fold(
            (failure) => HttpPostStatusError(message: failure.errorMessage),
            (addresses) => HttpPostStatusSuccess(data: addresses)

    );

  }

}