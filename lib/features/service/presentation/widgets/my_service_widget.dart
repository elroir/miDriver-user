import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/extension/date_time_extension.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../provider/cancel_service_provider.dart';
import '../provider/get_current_service_provider.dart';
import 'pickup_and_destination_button.dart';

class MyServiceWidget extends ConsumerWidget {
  const MyServiceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,ref) {
    final service = ref.read(getCurrentServiceProvider).value!;

    return SliverToBoxAdapter(
      child: Container(
        height:320,
        width: 600,
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(AppBorder.serviceBorderRadius)),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.serviceFormPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppStrings.dateAndTime,style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white70),),
                Text(service.serviceDateTime.toLiteralDateAndTime(context),style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),),
                Row(
                  children: [
                    const Icon(Iconsax.car,color: Colors.white70,),
                    const SizedBox(width: 10),
                    Text('${service.car!.make.makeName} ${service.car!.model} ${service.car!.year} ${service.car!.plate}',style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white),),
                  ],
                ),
                const Spacer(),
                FittedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppStrings.myPrice,style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white70)),
                      Text('Bs. ${service.price.toStringAsFixed(2)} + 20 Taxi',style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white,fontSize: 28))
                    ],
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    PickUpAndDestinationButton(
                      lat: service.origin.latitude,
                      lon: service.origin.longitude,
                    ),
                    PickUpAndDestinationButton(
                      isPickUp: false,
                      lat: service.destination.latitude,
                      lon: service.destination.longitude,
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(AppStrings.fareSelected,style: TextStyle(color: Colors.white70),),
                        Text('${service.fare.title} Bs.${service.fare.price.toStringAsFixed(2)}',style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white),),
                      ],
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            visualDensity: VisualDensity.compact,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            shape: const StadiumBorder()
                        ),
                        onPressed: () => ref.read(cancelServiceProvider.notifier).cancelService(),
                        child: const Text(AppStrings.cancel)
                    )
                  ],
                ),
                const SizedBox(height: 10,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
