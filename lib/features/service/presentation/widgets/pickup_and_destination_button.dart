import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/resources/strings_manager.dart';
import '../../../../core/router/router.dart';

class PickUpAndDestinationButton extends StatelessWidget {
  final double lat;
  final double lon;
  final bool isPickUp;
  const PickUpAndDestinationButton({super.key, required this.lat, required this.lon,this.isPickUp = true});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: () => context.go(
          Uri(
              path: '${Routes.services}/${Routes.location}',
              queryParameters: {
                'lat' : lat.toString(),
                'lon' : lon.toString(),
              }).toString(),
        ),
        child: Container(
          width: 100,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: [
              Icon(isPickUp ? Iconsax.location :Iconsax.location_tick,color: Colors.white,),
              Text(isPickUp ? AppStrings.pickupPlace :AppStrings.destinationPlace,style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white),textAlign: TextAlign.center,)
            ],
          ),
        )
    );
  }
}
