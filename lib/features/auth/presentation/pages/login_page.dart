import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/http/http_options.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/router/router.dart';
import '../../../../core/widgets/error_text_widget.dart';
import '../../../../core/widgets/loading_button.dart';
import '../../../home/presentation/provider/launch_url_provider.dart';
import '../provider/login_provider.dart';
import '../widgets/background_logo_widget.dart';
import '../widgets/password_field.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,ref) {
    final loginProvider = ref.watch(loginNotifierProvider);
    return Scaffold(
        body: Stack(
          children: [
            const BackGroundLogoWidget(),
            SafeArea(
              child: Center(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20,top: 40,bottom: 20),
                    child: Form(
                      key: loginProvider.key,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              onSaved: loginProvider.saveEmailField,
                              validator: loginProvider.validateEmail,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                  labelText: AppStrings.emailField
                              ),
                            ),
                            const SizedBox(height: 15),
                            PasswordField(
                              onSaved: loginProvider.savePasswordField,
                              validator: loginProvider.validatePassword,
                              textInputAction: TextInputAction.next,
                              onChanged: loginProvider.onChangePasswordField,
                            ),
                            if(loginProvider.hasErrors)
                              ErrorTextWidget(errorText: loginProvider.errorText),
                            TextButton(
                                onPressed: () => context.pushNamed(Routes.passwordRecovery),
                                child: Text(AppStrings.forgotPassword.toUpperCase(),style: const TextStyle(fontSize: 12),)
                            ),
                            LoadingButton(
                              onPressed: () => loginProvider.signIn(),
                              isLoading: loginProvider.loading,
                              buttonText: AppStrings.loginButton.toUpperCase(),
                            ),
                            TextButton(
                                onPressed: () => context.go(Routes.register),
                                child: const Text(AppStrings.noAccount)
                            ),
                            TextButton(
                                onPressed: () => ref.read(openUrlProvider.notifier).openUrl(HttpOptions.privacyPolicyUrl),
                                child: const Text(AppStrings.privacyPolicy)
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

