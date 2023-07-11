import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/router/router.dart';

class ServicePage extends StatelessWidget {
  const ServicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: SvgPicture.asset(AssetsManager.nothing,height: MediaQuery.of(context).size.height*0.36,),
            ),
            const SizedBox(height: 10),
            FractionallySizedBox(
                widthFactor: 0.8,
                child: Text(AppStrings.noServiceTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 25,fontWeight: FontWeight.bold)
                )
            ),
            const SizedBox(height: 10),
            FractionallySizedBox(
              widthFactor: 0.9,
              child: Text(AppStrings.noServiceDescription,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            FractionallySizedBox(
              widthFactor: 0.9,
              child: ElevatedButton(
                onPressed: () => context.pushNamed(Routes.newService),
                child: const Text(AppStrings.requestDriver),
              ),
            ),
            const SizedBox(height: 10),
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
