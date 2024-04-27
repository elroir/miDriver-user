import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/http/entities/http_post_status.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/router/router.dart';
import '../../../home/presentation/widgets/delete_dialog.dart';
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

    return FractionallySizedBox(
      widthFactor: 0.9,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.red)
        ),
        onPressed: () => ref.read(deleteAddressProvider.notifier).openDialog() ,
        child: const Text(AppStrings.delete,style: TextStyle(color: Colors.red),),
      ),
    );
  }
}
