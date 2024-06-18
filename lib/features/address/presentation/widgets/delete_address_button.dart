import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/http/entities/http_post_status.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/router/router.dart';
import '../../../home/presentation/widgets/delete_dialog.dart';
import '../../../map/presentation/provider/pick_location_provider.dart';
import '../provider/delete_address_provider.dart';
import '../provider/get_addresses_provider.dart';

class DeleteAddressButton extends ConsumerWidget {
  const DeleteAddressButton({super.key});

  @override
  Widget build(BuildContext context,ref) {

    ref.listen(deleteAddressProvider, (previous, next) {

      if(next is HttpPostStatusLoading){
        context.pop();
      }

      if(next is HttpPostStatusSuccess){
        context.pop();
        ref.read(pickLocationProvider.notifier).clearOrigin();
        ref.read(getAddressesProvider.notifier).getAddresses();
      }

      if(next is HttpPostStatusInProgress){
        showDialog(
            context: context,
            builder: (_) => DeleteDialog(
              title: AppStrings.deleteAddress,
              content: AppStrings.deleteAddressDescription,
              onSubmit: () => ref.read(deleteAddressProvider.notifier).deleteAddress()
            )
        );
      }
    });

    return Padding(
      padding: const EdgeInsets.only(left: AppPadding.horizontalPadding),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.red)    ,
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.horizontalPadding,vertical: 14)
        ),
        onPressed: () => ref.read(deleteAddressProvider.notifier).openDialog() ,
        child: const Text(AppStrings.delete,style: TextStyle(color: Colors.red),),
      ),
    );
  }
}
