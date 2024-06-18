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
              const SizedBox(height: 10),
              FractionallySizedBox(
                widthFactor: 0.9,
                child: TextFormField(
                    initialValue: ref.read(storeAddressProvider.notifier).title,
                    onSaved: ref.read(storeAddressProvider.notifier).saveTitleField,
                    validator: ref.read(storeAddressProvider.notifier).validateTitle,
                    decoration: const InputDecoration(
                      labelText: AppStrings.addressTitleField,
                      hintText: 'Casa'
                    )
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
                      hintText: 'Av. San martin, calle este, casa 4'
                    )
                ),
              ),
              const SizedBox(height: 40),
              if(addressStatus is HttpPostStatusError)
              ErrorTextWidget(
                  errorText: addressStatus.message
              ),
              FractionallySizedBox(
                widthFactor: 0.9,
                child: Row(
                  children: [
                    Flexible(
                      child: Center(
                        child: LoadingButton(
                          widthFactor: 1,
                            onPressed: () => ref.read(storeAddressProvider.notifier).storeOrEditAddress(),
                            buttonText: AppStrings.save,
                            isLoading: addressStatus is HttpPostStatusLoading
                        ),
                      ),
                    ),
                    if(ref.read(storeAddressProvider.notifier).isEditing)
                      const DeleteAddressButton()
                  ],
                ),
              ),


            ],
          )
      ),
    );
  }
}
