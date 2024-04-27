import 'package:flutter/material.dart';

import '../../../../core/resources/strings_manager.dart';
import '../../../../core/router/router.dart';
import '../../domain/entities/address.dart';

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
                color: address.defaultAddress ? Theme.of(context).highlightColor : Colors.transparent,
                width: 2
            ),
            borderRadius: BorderRadius.circular(10)
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          title: Text(address.textual),
          subtitle: address.defaultAddress ? const Text(AppStrings.defaultAddress) : const SizedBox(),
          onTap: () => context.push('${Routes.address}/${address.id}'),
        ),
      ),
    );
  }
}
