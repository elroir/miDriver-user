import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/widgets/main_picker.dart';
import '../../domain/entities/user_vehicle.dart';
import '../provider/get_vehicles_provider.dart';

class VehiclePicker extends ConsumerWidget {
  final TextEditingController textController;
  final void Function(String,UserVehicle?) onChanged;

  const VehiclePicker({Key? key,required this.textController,required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context,ref) {
    final vehicles = ref.watch(getVehiclesProvider);

    return vehicles.when(
        data: (cars) => MainPicker(
          itemTexts: cars.map((e) => '${e.make.makeName} ${e.model} ${e.plate}').toList(),
          textEditingController: textController,
          items: cars,
          required: true,
          icon: const Icon(Iconsax.car,color: Colors.black),
          backgroundColor: Colors.white,
          onChanged: onChanged,
        ),
        error: (error,stacktrace) => const SizedBox(),
        loading: () => const Center(child: CircularProgressIndicator.adaptive(),)
    );
  }
}
