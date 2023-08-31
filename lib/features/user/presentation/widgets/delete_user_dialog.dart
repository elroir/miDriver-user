import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/resources/strings_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/router/router.dart';
import '../provider/delete_user_provider.dart';

class DeleteUserDialog extends StatelessWidget {
  const DeleteUserDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(color: Colors.black),
            child: Text(AppStrings.deleteUser,style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white)),
          ),
          const SizedBox(height: 10),
          const Icon(Iconsax.trash,color: Colors.red,size: 50,),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.horizontalPadding),
            child: Text(AppStrings.deleteUserContent,style: Theme.of(context).textTheme.bodyLarge),
          ),
          const SizedBox(height: 10),

          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  child: FractionallySizedBox(
                    widthFactor: 0.9,
                    child: OutlinedButton(
                        onPressed: () => context.pop(),
                        child: const Text(AppStrings.cancel)
                    ),
                  ),
                ),
                Flexible(
                  child: FractionallySizedBox(
                    widthFactor: 0.9,
                    child: Consumer(
                        builder: (_,ref,child) =>  ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red
                          ),
                            onPressed: () => ref.read(deleteUserProvider.notifier).deleteUser(),
                            child: const Text(AppStrings.delete)
                        )
                    ),
                  ),
                ),
              ]
          ),
          const SizedBox(height: 10)

        ],
      ),
    );
  }
}
