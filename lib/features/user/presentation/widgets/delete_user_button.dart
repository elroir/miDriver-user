import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/http/entities/http_post_status.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/router/router.dart';
import '../provider/delete_user_provider.dart';
import 'delete_user_dialog.dart';

class DeleteUserButton extends ConsumerWidget {
  final String text;
  const DeleteUserButton({super.key,this.text = AppStrings.deleteUser});

  @override
  Widget build(BuildContext context,ref) {

    ref.listen(deleteUserProvider, (previous, next) {

      if(next is HttpPostStatusLoading){
        context.pop();
      }

      if(next is HttpPostStatusInProgress){
        showDialog(
            context: context,
            builder: (_) => const DeleteUserDialog()
        );
      }
    });


    return FractionallySizedBox(
      widthFactor: 0.9,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.red)
        ),
        onPressed: () => ref.read(deleteUserProvider.notifier).openDialog() ,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(text,style: const TextStyle(color: Colors.red),)
          ],
        ),
      ),
    );
  }
}