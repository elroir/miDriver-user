import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/router/router.dart';
import '../provider/get_current_service_provider.dart';

class ServiceFinishedPage extends ConsumerWidget {
  const ServiceFinishedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,ref) {

    final service = ref.read(getCurrentServiceProvider).value!;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SvgPicture.asset(AssetsManager.buyingCar,height: MediaQuery.of(context).size.height*0.36,),
            ),
            FractionallySizedBox(
                widthFactor: 0.8,
                child: Text('${AppStrings.price} Bs. ${service.price.toStringAsFixed(2)} + Bs. 20 para taxi',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 25,fontWeight: FontWeight.bold)
                )
            ),

            const SizedBox(height: 10),
            FractionallySizedBox(
              widthFactor: 0.9,
              child: Text(AppStrings.thanksForUsingOurServices,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            FractionallySizedBox(
              widthFactor: 0.9,
              child: ElevatedButton(
                onPressed: () => context.pop(),
                child: const Text(AppStrings.finish),
              ),
            ),
            const SafeArea(
                bottom: true,
                child: SizedBox(height: 30)
            )
          ],
        ),
      ),
    );
  }
}
