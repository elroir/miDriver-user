import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/resources/values_manager.dart';
import '../../../../core/router/router.dart';
import '../../../service/presentation/widgets/default_address_service_dialog.dart';
import '../../domain/entities/address.dart';
import '../provider/pick_address_provider.dart';

class AddressCard extends StatelessWidget {
  final Address address;
  const AddressCard({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            border: Border.all(
                color: AppColors.primaryColor,
                width: 2
            ),
            borderRadius: BorderRadius.circular(10)
        ),
        child: Consumer(
          builder: (context,ref,child) {
            return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                title: Text(address.title),
                subtitle: Text(address.address),
                trailing: InkWell(
                    onTap: () => context.push('${Routes.addressForm}/${address.id}'),
                    child: const Icon(Iconsax.edit
                    )
                ),
                onTap: () {
                  ref.read(pickAddressesProvider.notifier).pickAddressId(address.id);
                  showDialog(
                      context: context,
                      builder: (_) => const DefaultAddressServiceDialog()
                  );
                }
            );
          },
        ),
      ),
    );
  }
}
