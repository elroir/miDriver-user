import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/http/entities/http_post_status.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/router/router.dart';
import '../../../../core/widgets/error_text_widget.dart';
import '../../../../core/widgets/loading_button.dart';
import '../provider/password_recovery_provider.dart';
import '../widgets/background_logo_widget.dart';

class RecoverPasswordPage extends ConsumerWidget {
  const RecoverPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,ref) {

    final passwordRecovery = ref.watch(passwordRecoveryProvider);

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
                      key: ref.read(passwordRecoveryProvider.notifier).key,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(AppStrings.forgotPasswordTitle,style: Theme.of(context).textTheme.titleSmall,textAlign: TextAlign.center),
                            const SizedBox(height: 30),
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              validator: ref.read(passwordRecoveryProvider.notifier).validateEmail,
                              onSaved: ref.read(passwordRecoveryProvider.notifier).saveEmailField,
                              decoration: const InputDecoration(
                                  labelText: AppStrings.emailField
                              ),
                            ),
                            const SizedBox(height: 30),
                            if(passwordRecovery is HttpPostStatusError)
                              ErrorTextWidget(errorText: passwordRecovery.message),
                            (passwordRecovery is HttpPostStatusSuccess)
                              ? const Text(AppStrings.recoverySuccessful,textAlign: TextAlign.center)
                              : LoadingButton(
                                  onPressed: ref.read(passwordRecoveryProvider.notifier).requestPasswordRecovery,
                                  isLoading: passwordRecovery is HttpPostStatusLoading,
                                  buttonText: AppStrings.sendRecovery.toUpperCase(),
                                ),
                            TextButton(
                                onPressed: () => context.pop(),
                                child: Text(AppStrings.goBack.toUpperCase())
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