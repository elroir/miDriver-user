import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/http/entities/http_post_status.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/widgets/loading_button.dart';
import '../../../../core/widgets/main_picker.dart';
import '../../../map/presentation/provider/direction_provider.dart';
import '../../../map/presentation/provider/pick_location_provider.dart';
import '../../../map/presentation/widgets/map_widget.dart';
import '../../../vehicle/presentation/provider/get_vehicles_provider.dart';

class ServiceFormPage extends ConsumerWidget {
  const ServiceFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,ref) {
    final vehicles = ref.watch(getVehiclesProvider);
    final locationSelection = ref.watch(pickLocationProvider);
    final directions = ref.watch(directionProvider);

    return Scaffold(

      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            const MapWidget(),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                child: vehicles.when(
                    data: (cars) => MainPicker(
                        itemTexts: cars.map((e) => '${e.make.makeName} ${e.model} ${e.plate}').toList(),
                        textEditingController: TextEditingController(),
                        items: cars,
                        required: true,
                        onChanged: (val,selected){}
                    ),
                    error: (error,stacktrace) => const SizedBox(),
                    loading: () => const Center(child: CircularProgressIndicator.adaptive(),)
                ),
              ),
            ),
            if(locationSelection is LocationSelectionDestination)
              SafeArea(
                bottom: true,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom:20),
                    child: LoadingButton(
                      widthFactor: 0.9,
                      fixedHeight: 46,
                      isLoading: directions is HttpPostStatusLoading,
                      onPressed: () => ref.read(directionProvider.notifier).getDirections(locationSelection.destination!),
                      buttonText: AppStrings.confirm
                    ),
                  ),
                ),
              )


          ],
        ),
      ),
    );
  }
}
