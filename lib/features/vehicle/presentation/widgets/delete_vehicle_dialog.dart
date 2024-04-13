import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/resources/strings_manager.dart';
import '../../../home/presentation/widgets/delete_dialog.dart';
import '../provider/delete_vehicle_provider.dart';

class DeleteVehicleDialog extends ConsumerWidget {
  const DeleteVehicleDialog({super.key});

  @override
  Widget build(BuildContext context,ref) {
    return DeleteDialog(
      title: AppStrings.deleteVehicle,
      content: AppStrings.deleteVehicleContent,
      onSubmit: () => ref.read(deleteVehicleProvider.notifier).deleteVehicle(),
    );
  }
}
