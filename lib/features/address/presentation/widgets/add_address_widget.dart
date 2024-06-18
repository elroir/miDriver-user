import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/router/router.dart';

class AddAddressWidget extends StatelessWidget {
  const AddAddressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push(Routes.addressForm),
      child: Container(
        height: 100,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppBorder.cardBorderRadius),
            gradient: const LinearGradient(
                colors: [
                  Colors.black,
                  Colors.black,
                  Colors.black87,
                  Colors.black87
                ],
                stops: [
                  0,
                  0.3,
                  0.6,
                  0.9
                ]
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppStrings.noAvailableAddresses,style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white)),
            Row(
              children: [
                Flexible(
                  child: Column(
                    children: [
                      Text('Registre una nueva',style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white))
                    ],
                  ),
                ),
                const Spacer(),
                const Icon(Iconsax.location_add,size: 42,color: Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }
}