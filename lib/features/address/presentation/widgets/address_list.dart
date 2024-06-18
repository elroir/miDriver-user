import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/http/entities/http_post_status.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/router/router.dart';
import '../provider/get_addresses_provider.dart';
import 'add_address_widget.dart';
import 'address_card.dart';

class AddressList extends ConsumerWidget {
  const AddressList({super.key});

  @override
  Widget build(BuildContext context,ref) {
    final addresses = ref.watch(getAddressesProvider);
    if(addresses is HttpPostStatusSuccess){
      if(addresses.data!.isEmpty){
        return const SliverToBoxAdapter(child: AddAddressWidget());
      }
      return SliverList(
          delegate: SliverChildBuilderDelegate(
                  (_,i) => (i>=addresses.data!.length)
                  ? FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Padding(
                    padding: const EdgeInsets.only(top: AppPadding.topPadding,bottom: AppPadding.addressListButtonPadding),
                    child: ElevatedButton(
                        onPressed: () => context.push(Routes.addressForm),
                        child: const Text(AppStrings.addAddress)
                    ),
                  )
              )
                  : AddressCard(address: addresses.data![i]),
              childCount: addresses.data!.length+1
          )
      );
    }

    return const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator.adaptive()));



  }
}
