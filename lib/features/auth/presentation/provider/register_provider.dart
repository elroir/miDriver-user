import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/form/form_provider.dart';
import '../../../../core/form/form_validators.dart';
import '../../../../core/router/router.dart';
import '../../../../repositories.dart';
import '../../domain/use_cases/save_auth_user_use_case.dart';
import '../../domain/use_cases/verify_email_use_case.dart';


final registerNotifierProvider = ChangeNotifierProvider(
        (ref) => RegisterNotifier(ref.read(Repositories.saveAuthUserUseCase),ref.read(formProvider),ref.read(Repositories.verifyEmailUseCase),ref.read(router))
);

class RegisterNotifier extends ChangeNotifier{

  final SaveAuthUser _saveAuthUser;
  final VerifyEmail _verifyEmail;
  final GlobalKey<FormState> key;
  final GoRouter router;
  String _email = '';
  String _password = '';
  bool emailExists = false;
  bool isLoading = false;
  String errorText = '';

  RegisterNotifier(this._saveAuthUser,this.key, this._verifyEmail, this.router);

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

  String? validateRepeatedPassword(String? value){

    return FormValidators.validateEqual(value??'', _password);
  }

  String? validateEmail(String? value){
    return FormValidators.validateEmail(value);
  }

  Future<void> continueSignUpProcess() async{
    final FormState form = key.currentState!;
    if(!form.validate()) return;
    form.save();
    isLoading = true;
    notifyListeners();
    final trimmedEmail = _email.trim();
    final emailVerified = await _verifyEmail(trimmedEmail);
    isLoading = false;

    emailVerified.fold(
            (error) {
              emailExists = true;
              errorText = error.errorMessage;
              notifyListeners();
            },
            (r) {
              emailExists = false;
              notifyListeners();
              _saveAuthUser(trimmedEmail,_password);
              router.pushNamed(Routes.personalData);
            }
    );



  }

}