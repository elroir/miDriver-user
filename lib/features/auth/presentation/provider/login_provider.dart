
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/form/form_provider.dart';
import '../../../../core/form/form_validators.dart';
import '../../../../core/router/router.dart';
import '../../../../repositories.dart';
import '../../domain/use_cases/sign_in_with_email_use_case.dart';

final loginNotifierProvider = ChangeNotifierProvider.autoDispose(
        (ref) => LoginNotifier(ref.read(Repositories.loginUseCase),ref.read(formProvider),ref.read(router))
);

class LoginNotifier extends ChangeNotifier{

  final SignInWithEmail _signInWithEmail;
  final GlobalKey<FormState> key;
  final GoRouter _router;
  String _email = '';
  String _password = '';
  bool loading = false;
  bool hasErrors = false;
  String errorText = '';

  LoginNotifier(this._signInWithEmail, this.key, this._router);

  void saveEmailField(String? value){
    _email = value ?? '';
  }

  void savePasswordField(String? value){
    _password = value ?? '';
  }

  void onChangePasswordField(String? value){
    _password = value ?? '';
  }

  String? validatePassword(String? value){
    return FormValidators.validateNotShorter(value,length: 8);
  }

  String? validateEmail(String? value){
    return FormValidators.validateEmail(value);
  }

  Future<void> signIn() async {
    final FormState form = key.currentState!;
    if(!form.validate()) return;
    form.save();
    loading = true;
    notifyListeners();
    final response = await _signInWithEmail(_email.trim(),_password);
    loading = false;
    response.fold(
            (error) {
              errorText = error.errorMessage;
              hasErrors = true;
              notifyListeners();
        },
            (authStatus) {
              _router.go(Routes.profile);
            }

    );


  }

}