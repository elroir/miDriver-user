import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/http/entities/http_post_status.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/widgets/error_text_widget.dart';
import '../../../../core/widgets/loading_button.dart';
import '../../../map/presentation/provider/pick_location_provider.dart';
import '../provider/get_addresses_provider.dart';
import '../provider/store_address_provider.dart';
import 'delete_address_button.dart';

class AddressForm extends ConsumerWidget {
  const AddressForm({super.key});

  @override
  Widget build(BuildContext context,ref) {
    final addressStatus = ref.watch(storeAddressProvider);
    ref.listen(storeAddressProvider, (previous, next) {
      if(next is HttpPostStatusSuccess){
        ref.read(getAddressesProvider.notifier).getAddresses();
        ref.read(pickLocationProvider.notifier).clearOrigin();
      }
    });
    return Form(
      key: ref.read(storeAddressProvider.notifier).key,
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: Column(

            mainAxisSize: MainAxisSize.max,
            children: [
              (ref.read(getAddressesProvider).data!.isEmpty || !ref.read(storeAddressProvider.notifier).canChangeDefaultAddress)
                ? const FractionallySizedBox(
                    widthFactor: 0.9,
                    child: Text(AppStrings.defaultAddressDescription)
                )
              : FractionallySizedBox(
                widthFactor: 0.9,
                child: SwitchListTile.adaptive(
                  contentPadding: const EdgeInsets.all(0),
                  title: const Text(AppStrings.defaultAddress),
                    value: ref.watch(storeAddressSwitchProvider),
                    onChanged: (value) => ref.read(storeAddressSwitchProvider.notifier).update(
                            (state) {
                              ref.read(storeAddressProvider.notifier).saveDefaultAddressField(value);
                              return state = value;
                            }
                    ) ,
                ),
              ),
              const SizedBox(height: 10),
              FractionallySizedBox(
                widthFactor: 0.9,
                child: TextFormField(
                  initialValue: ref.read(storeAddressProvider.notifier).address,
                  onSaved: ref.read(storeAddressProvider.notifier).saveAddressField,
                    validator: ref.read(storeAddressProvider.notifier).validateAddress,
                    decoration: const InputDecoration(
                        labelText: AppStrings.addressField,
                    )
                ),
              ),
              const SizedBox(height: 40),
              if(addressStatus is HttpPostStatusError)
              ErrorTextWidget(
                  errorText: addressStatus.message
              ),
              LoadingButton(
                  onPressed: () => ref.read(storeAddressProvider.notifier).storeOrEditAddress(),
                  buttonText: AppStrings.save,
                  isLoading: addressStatus is HttpPostStatusLoading
              ),
              const SizedBox(height: 20),
              if(ref.read(storeAddressProvider.notifier).isEditing)
                const DeleteAddressButton()

            ],
          )
      ),
    );
  }
}
