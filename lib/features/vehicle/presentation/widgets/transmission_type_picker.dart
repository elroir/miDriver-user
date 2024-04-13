import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/resources/strings_manager.dart';
import '../provider/transmission_type_provider.dart';

class TransmissionTypePicker extends ConsumerWidget {
  const TransmissionTypePicker({super.key});

  @override
  Widget build(BuildContext context,ref) {

    final transmissionType = ref.watch(transmissionTypeProvider);

    return Column(
      children: [
        RadioListTile(
            groupValue: transmissionType,
            value: AppStrings.automatic,
            onChanged: (value) => ref.read(transmissionTypeProvider.notifier).changeTransmissionField(value!),
          title: const Text(AppStrings.automatic),
        ),
        RadioListTile(
          groupValue: transmissionType,
          value: AppStrings.manual,
          onChanged: (value) => ref.read(transmissionTypeProvider.notifier).changeTransmissionField(value!),
          title: const Text(AppStrings.manual),
        ),
      ],
    );
  }
}
