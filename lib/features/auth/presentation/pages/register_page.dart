import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/resources/strings_manager.dart';
import '../../../../core/router/router.dart';
import '../../../../core/widgets/button_loading_animation.dart';
import '../../../../core/widgets/error_text_widget.dart';
import '../provider/register_provider.dart';
import '../widgets/background_logo_widget.dart';
import '../widgets/password_field.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,ref) {
    final registerProvider = ref.watch(registerNotifierProvider);

    return Scaffold(
        body: Stack(
          children: [
            const BackGroundLogoWidget(),
            SafeArea(
              child: Center(
                child: Card(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20,top: 40,bottom: 20),
                      child: Form(
                        key: registerProvider.key,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              onSaved: registerProvider.saveEmailField,
                              validator: registerProvider.validateEmail,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                labelText: AppStrings.emailField
                              ),
                            ),
                            const SizedBox(height: 15),
                            PasswordField(
                              onSaved: registerProvider.savePasswordField,
                              validator: registerProvider.validatePassword,
                              textInputAction: TextInputAction.next,
                              onChanged: registerProvider.onChangePasswordField,
                            ),
                            const SizedBox(height: 15),
                            PasswordField(
                              validator: registerProvider.validateRepeatedPassword,
                              textInputAction: TextInputAction.send,
                              onFieldSubmitted: (val) => registerProvider.continueSignUpProcess(),
                              labelText: AppStrings.confirmPasswordField,
                            ),
                            const SizedBox(height: 30),
                            if(registerProvider.emailExists)
                            ErrorTextWidget(errorText: registerProvider.errorText),

                            FractionallySizedBox(
                              widthFactor: 0.9,
                              child: ElevatedButton(
                                onPressed: registerProvider.isLoading ? null : () => registerProvider.continueSignUpProcess(),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Text(AppStrings.continueRegister.toUpperCase()),
                                    if(registerProvider.isLoading)
                                      const ButtonLoadingAnimation(color: Colors.white)
                                  ],
                                )
                              ),
                            ),
                            TextButton(
                                onPressed: () => context.go(Routes.login),
                                child: const Text(AppStrings.haveAccount)
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        )
    );
  }
}
