import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/http/entities/http_post_status.dart';
import '../../../../repositories.dart';
import '../../domain/use_cases/delete_address_use_case.dart';
import 'store_address_provider.dart';

final deleteAddressProvider = StateNotifierProvider.autoDispose<DeleteAddressProvider,HttpPostStatus>(
        (ref) {
          final addressId = ref.read(storeAddressProvider.notifier).addressId;
      return DeleteAddressProvider(ref.read(Repositories.deleteAddressUseCase),addressId);
    }
);


class DeleteAddressProvider extends StateNotifier<HttpPostStatus>{

  final DeleteAddress _deleteAddress;
  final int _addressId;
  DeleteAddressProvider(this._deleteAddress,this._addressId)  : super(HttpPostStatusNone());

  void openDialog(){
    state = HttpPostStatusInProgress();
  }

  Future<void> deleteAddress() async {
    state = HttpPostStatusLoading();
    final result = await _deleteAddress(_addressId);
    state = result.fold(
            (error) => HttpPostStatusError(message:error.errorMessage),
            (success) => HttpPostStatusSuccess()
    );
  }

}