import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/resources/strings_manager.dart';
import '../../../../core/router/router.dart';
import '../../../vehicle/presentation/widgets/add_vehicle.dart';
import '../provider/get_addresses_provider.dart';
import 'address_card.dart';

class AddressList extends ConsumerWidget {
  const AddressList({super.key});

  @override
  Widget build(BuildContext context,ref) {
    final addresses = ref.watch(getAddressesProvider);
    if(addresses.isEmpty){
      return const SliverToBoxAdapter(child: AddVehicleWidget());
    }

    return SliverList(
        delegate: SliverChildBuilderDelegate(
                (_,i) => (i>=addresses.length)
                ? FractionallySizedBox(
                widthFactor: 0.9,
                child: ElevatedButton(
                    onPressed: () => context.push(Routes.address),
                    child: const Text(AppStrings.addAddress)
                )
            )
                : AddressCard(address: addresses[i]),
            childCount: addresses.length+1
        )
    );

  }
}
