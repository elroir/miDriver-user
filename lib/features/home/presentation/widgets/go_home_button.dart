import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../service/presentation/provider/get_current_service_provider.dart';
import '../../../service/presentation/widgets/default_address_service_dialog.dart';

class GoHomeButton extends ConsumerWidget {
  const GoHomeButton({super.key});

  @override
  Widget build(BuildContext context,ref) {
    final currentService = ref.watch(getCurrentServiceProvider);

    return currentService.when(
        data: (service) => const SizedBox(),
        error: (error,_) {
          if(error is NoServiceFailure){
            return FloatingActionButton.extended(
              onPressed: () => showDialog(
                  context: context,
                  builder: (_) => const DefaultAddressServiceDialog()
              ),
              backgroundColor: AppColors.primaryColor,
              label: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Iconsax.home,color: Colors.white,),
                  Text(AppStrings.goHome,style: TextStyle(color: Colors.white),)
                ],
              ),
            );
          }
          return const SizedBox();
        },
        loading: () => const SizedBox()
    );
  }
}
