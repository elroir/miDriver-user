import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/form/form_provider.dart';
import '../../../../core/form/form_validators.dart';
import '../../../../core/http/entities/http_post_status.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../repositories.dart';
import '../../domain/use_cases/request_password_recovery_use_case.dart';

final passwordRecoveryProvider = StateNotifierProvider.autoDispose<PasswordRecoveryNotifier,HttpPostStatus>(
        (ref) => PasswordRecoveryNotifier(ref.read(Repositories.requestPasswordRecoveryUseCase),ref.read(formProvider))
);

class PasswordRecoveryNotifier extends StateNotifier<HttpPostStatus>{

  final RequestPasswordRecovery _passwordRecovery;
  final GlobalKey<FormState> key;
  String _email = '';


  PasswordRecoveryNotifier(this._passwordRecovery, this.key) : super(HttpPostStatusNone());


  void saveEmailField(String? value){
    _email = value ?? '';
  }

  String? validateEmail(String? value){
    return FormValidators.validateEmail(value);
  }

  Future<void> requestPasswordRecovery() async {
    final FormState form = key.currentState!;
    if(!form.validate()) return;
    form.save();
    state = HttpPostStatusLoading();
    final recoverOrFailure = await _passwordRecovery(_email);
    recoverOrFailure.fold(
            (error) => state = HttpPostStatusError(message: error.errorMessage),
            (status) {
          state = HttpPostStatusSuccess(message: AppStrings.thanksForRegisteringDescription);
        }
    );
  }

}