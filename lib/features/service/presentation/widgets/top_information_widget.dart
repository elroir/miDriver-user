import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/resources/values_manager.dart';
import '../../../../core/widgets/pickers/date_picker_widget.dart';
import '../../../../core/widgets/pickers/time_picker.dart';
import '../../../map/presentation/provider/pick_location_provider.dart';
import '../../../vehicle/presentation/widgets/transport_type_picker.dart';
import '../provider/service_form_provider.dart';

class TopInformationWidget extends ConsumerWidget {
  const TopInformationWidget({super.key});

  @override
  Widget build(BuildContext context,ref) {

    final locationSelection = ref.watch(pickLocationProvider);
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 800),
          height: (locationSelection is LocationSelectionComplete) ? 240 : 60,
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
                            child: TransportTypePicker(
                                textController: ref.read(serviceFormProvider.notifier).vehicleController,
                                onChanged: (value,transportType) => ref.read(serviceFormProvider.notifier).pickTransportType(transportType!)
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: DatePickerWidget(
                                  decoration: const InputDecoration(
                                      fillColor: Colors.white,
                                      prefixIcon: Icon(Iconsax.calendar_1,color: Colors.black)
                                  ),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now().add(const Duration(days: 30)),
                                  controller: ref.read(serviceFormProvider.notifier).dateController,
                                ),
                              ),
                              Flexible(
                                child: TimePicker(
                                  widthFactor: 0.9,
                                  decoration: const InputDecoration(
                                      fillColor: Colors.white,
                                      prefixIcon: Icon(Iconsax.clock,color: Colors.black)
                                  ),
                                  controller: ref.read(serviceFormProvider.notifier).timeController,
                                ),
                              )
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: FittedBox(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text('Bs. ${ref.read(serviceFormProvider.notifier).price.toStringAsFixed(2)} + Bs. 20 Taxi' ,style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),),
                                      const SizedBox(width: 5),
                                      Text('(${ref.read(serviceFormProvider.notifier).distanceInKm.toStringAsFixed(2)} Km)',style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white70),),

                                    ],
                                  ),
                                ],
                              ),
                            ),
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

              ],
            ),
          ),
        ),
      ),
    );
  }
}
