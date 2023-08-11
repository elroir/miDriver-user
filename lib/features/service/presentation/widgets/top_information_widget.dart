import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/resources/values_manager.dart';
import '../../../map/presentation/provider/pick_location_provider.dart';
import '../../../vehicle/presentation/widgets/vehicle_picker.dart';
import '../provider/service_form_provider.dart';

class TopInformationWidget extends ConsumerWidget {
  const TopInformationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,ref) {

    final locationSelection = ref.watch(pickLocationProvider);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 800),
      height: (locationSelection is LocationSelectionComplete) ? 200 : 80,
      color: Colors.black,
      child: Form(
        key: ref.read(serviceFormProvider.notifier).key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
                child: Row(
                  children: [
                    const BackButton(
                        color: Colors.white
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(right: AppPadding.serviceFormPadding),
                        child: VehiclePicker(
                            textController: ref.read(serviceFormProvider.notifier).vehicleController,
                            onChanged: (value,vehicle) => ref.read(serviceFormProvider.notifier).pickVehicle(vehicle!)
                        ),
                      ),
                    )
                  ],
                )
            ),
            if (locationSelection is LocationSelectionComplete)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppPadding.serviceFormPadding,vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text('Bs. ${ref.read(serviceFormProvider.notifier).price.toStringAsFixed(2)}',style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),),
                                  const SizedBox(width: 5),
                                  Text('(${ref.read(serviceFormProvider.notifier).distanceInKm.toStringAsFixed(2)} Km)',style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white70),),

                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      FractionallySizedBox(
                        widthFactor: 1,
                        child: OutlinedButton(
                          onPressed: () => ref.read(pickLocationProvider.notifier).restart(),
                          child: const Text('Elegir nuevamente',style: TextStyle(color: Colors.white),)
                        ),
                      )
                    ],
                  ),
                ),
              )
            // Row(
            //   children: [
            //     Card(
            //       child: Column(
            //         children: [
            //           Icon(Icons.add),
            //           Text('Origen')
            //         ],
            //       ),
            //     )
            //   ],
            // )

          ],
        ),
      ),
    );
  }
}
