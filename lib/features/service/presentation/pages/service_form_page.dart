import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/main_picker.dart';
import '../../../map/presentation/widgets/map_widget.dart';
import '../../../vehicle/presentation/provider/get_vehicles_provider.dart';

class ServiceFormPage extends ConsumerWidget {
  const ServiceFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,ref) {
    final vehicles = ref.watch(getVehiclesProvider);
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
                        onChanged: (val,selected){}
                    ),
                    error: (error,stacktrace) => const SizedBox(),
                    loading: () => const Center(child: CircularProgressIndicator.adaptive(),)
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
