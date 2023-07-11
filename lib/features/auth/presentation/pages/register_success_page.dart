import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/router/router.dart';
import '../widgets/logout_button.dart';


class RegisterSuccessPage extends StatelessWidget {
  const RegisterSuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SvgPicture.asset(AssetsManager.buyingCar,height: MediaQuery.of(context).size.height*0.36,),
            ),
            const SizedBox(height: 10),
            FractionallySizedBox(
               widthFactor: 0.8,
                child: Text(AppStrings.thanksForRegisteringTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 25,fontWeight: FontWeight.bold)
                )
            ),
             const SizedBox(height: 10),
             FractionallySizedBox(
               widthFactor: 0.9,
               child: Text(AppStrings.thanksForRegisteringDescription,
                 style: Theme.of(context).textTheme.bodyLarge,
                 textAlign: TextAlign.center,
               ),
             ),
            const Spacer(),
            FractionallySizedBox(
              widthFactor: 0.9,
              child: ElevatedButton(
                onPressed: () => context.push(Routes.documents),
                child: const Text(AppStrings.continueString),
              ),
            ),
            const SizedBox(height: 10),
            const LogoutButton(),
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
