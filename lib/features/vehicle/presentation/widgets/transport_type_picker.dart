import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/resources/strings_manager.dart';
import '../../../../core/widgets/pickers/main_picker.dart';
import '../../domain/entities/transport_type.dart';
import '../provider/get_transport_types_provider.dart';

class TransportTypePicker extends ConsumerWidget {
  final TextEditingController textController;
  final void Function(String,TransportType?) onChanged;

  const TransportTypePicker({super.key,required this.textController,required this.onChanged});

  @override
  Widget build(BuildContext context,ref) {
    final transports = ref.watch(getTransportTypesProvider);

    return transports.when(
      skipLoadingOnReload: false,
        data: (cars) => MainPicker(
          itemTexts: cars.map((e) => e.name).toList(),
          textEditingController: textController,
          items: cars,
          required: true,
          labelText: AppStrings.transportType,
          icon: const Icon(Iconsax.car,color: Colors.black),
          backgroundColor: Colors.white,
          onChanged: onChanged,
        ),
        error: (error,stacktrace) => FractionallySizedBox(
          widthFactor: 1,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red
              ),
              onPressed: () => ref.invalidate(getTransportTypesProvider),
              child: Text('Error, ${AppStrings.reloadButton.toLowerCase()}')
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator.adaptive(),)
    );
  }
}