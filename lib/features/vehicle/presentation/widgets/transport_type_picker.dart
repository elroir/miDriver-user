import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/widgets/pickers/main_picker.dart';
import '../../domain/entities/transport_type.dart';
import '../provider/get_transport_types_provider.dart';

class TransportTypePicker extends ConsumerWidget {
  final TextEditingController textController;
  final void Function(String,TransportType?) onChanged;

  const TransportTypePicker({Key? key,required this.textController,required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context,ref) {
    final transports = ref.watch(getTransportTypesProvider);

    return transports.when(
        data: (cars) => MainPicker(
          itemTexts: cars.map((e) => e.name).toList(),
          textEditingController: textController,
          items: cars,
          required: true,
          labelText: 'Tipo de transporte',
          icon: const Icon(Iconsax.car,color: Colors.black),
          backgroundColor: Colors.white,
          onChanged: onChanged,
        ),
        error: (error,stacktrace) => const SizedBox(),
        loading: () => const Center(child: CircularProgressIndicator.adaptive(),)
    );
  }
}