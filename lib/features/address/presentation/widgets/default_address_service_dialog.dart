
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/router/router.dart';
import '../../../fare/presentation/provider/get_fares_provider.dart';

import '../../../home/presentation/pages/error_view.dart';
import '../../../vehicle/presentation/widgets/transport_type_row.dart';

class DefaultAddressServiceDialog extends ConsumerWidget {


  const DefaultAddressServiceDialog({super.key});

  @override
  Widget build(BuildContext context,ref) {
    final faresProvider = ref.watch(getFaresProvider);
    return Dialog(
      clipBehavior: Clip.antiAlias,
      child: faresProvider.when(
        skipError: false,
          data: (fares) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(color: Colors.black),
                child: Text('Ir a mi dirección',style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white)),
              ),
              const SizedBox(height: 10),
              const TransportTypeRow(),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.horizontalPadding),
                child: Text('Estas a punto de solicitar un conductor desde tu ubicación actual hasta tu dirección por defecto',style: Theme.of(context).textTheme.bodyLarge),
              ),
              const SizedBox(height: 10),

              FractionallySizedBox(
                widthFactor: 0.9,
                child: OutlinedButton(
                    onPressed: () => context.pop(),
                    child: const Text(AppStrings.cancel)
                ),
              ),
              const SizedBox(height: 10)

            ],
          ),
          error: (error,_) => ErrorView(
            errorText: (error as Failure).errorMessage,
              onTap: () => ref.invalidate(getFaresProvider)
          ),
          loading: () => SizedBox(
            height: MediaQuery.sizeOf(context).height*0.5,
              child: const Center(child: CircularProgressIndicator.adaptive())
          )
      ),
    );
  }
}
