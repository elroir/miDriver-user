import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/resources/strings_manager.dart';
import '../../../home/presentation/widgets/delete_dialog.dart';
import '../provider/delete_user_provider.dart';

class DeleteUserDialog extends ConsumerWidget {
  const DeleteUserDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,ref) {
    return DeleteDialog(
      title: AppStrings.deleteUser,
      content: AppStrings.deleteUserContent,
      onSubmit: () => ref.read(deleteUserProvider.notifier).deleteUser(),
    );
  }
}
