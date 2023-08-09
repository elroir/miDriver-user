import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../../core/resources/values_manager.dart';
import '../../../home/presentation/pages/error_view.dart';
import '../../../map/presentation/widgets/location_selection_button.dart';
import '../../../map/presentation/widgets/map_widget.dart';
import '../../../vehicle/presentation/widgets/vehicle_picker.dart';
import '../provider/service_fare_provider.dart';
import '../provider/service_form_provider.dart';

class ServiceFormPage extends ConsumerWidget {
  final int fareId;
  const ServiceFormPage({Key? key,required this.fareId}) : super(key: key);

  @override
  Widget build(BuildContext context,ref) {

    final serviceFare = ref.watch(serviceFareProvider(fareId));


    return Scaffold(

      body: serviceFare.when(
          data: (fare) {
            ref.read(serviceFormProvider.notifier).pickFare(fare);
            final serviceForm = ref.watch(serviceFormProvider);

            return Stack(
              fit: StackFit.expand,
              children: [
                const MapWidget(),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 200,
                    color: Colors.black,
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
                ),
                const SafeArea(
                  bottom: true,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom:20),
                      child: LocationSelectionButton()

                    ),
                  ),
                )


              ],
            );
          } ,
          error: (error,_) => ErrorView(onTap: () => ref.invalidate(serviceFareProvider(fareId))),
          loading: () => const Center(child: CircularProgressIndicator.adaptive())
      )
    );
  }
}
