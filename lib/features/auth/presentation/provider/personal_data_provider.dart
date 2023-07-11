import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/form/form_provider.dart';
import '../../../../core/form/form_validators.dart';
import '../../../../core/router/router.dart';
import '../../../../repositories.dart';
import '../../domain/entities/personal_data.dart';
import '../../domain/use_cases/register_use_case.dart';
import '../../domain/use_cases/save_personal_data_use_case.dart';


final personalDataProvider = ChangeNotifierProvider(
        (ref) => PersonalDataNotifier(
            ref.read(Repositories.savePersonalDataUseCase),
            ref.read(Repositories.registerUseCase),
            ref.read(formProvider),
            ref.read(router)
        )
);

class PersonalDataNotifier extends ChangeNotifier{

  final SavePersonalData _savePersonalData;
  final SignUp _signUp;
  final GlobalKey<FormState> key;
  final GoRouter _router;
  bool loading = false;
  bool hasErrors = false;
  String errorText = '';
  String _name = '';
  String _lastName = '';
  int _phoneNumber = 0;
  String _address = '';

  PersonalDataNotifier(this._savePersonalData,this._signUp, this.key, this._router);


  void saveNameField(String? value){
    _name = value ?? '';
  }

  void saveLastNameField(String? value){
    _lastName = value ?? '';
  }

  void savePhoneNumberField(String? value){
    _phoneNumber = int.parse(value ?? '0');
  }

  void saveAddressField(String? value){
    _address = value ?? '';
  }

  String? validateNotEmpty(String? value){
    return FormValidators.validateNotShorter(value);
  }

  String? validatePhone(String? value){
    return FormValidators.validatePhoneNumber(value);
  }

  Future<void> register() async {
    final FormState form = key.currentState!;
    if(!form.validate()) return;
    form.save();

    loading = true;
    notifyListeners();
    final personalData = PersonalData(name: _name, lastName: _lastName, address: _address, phone: _phoneNumber);
    _savePersonalData(personalData);

    final response = await _signUp();
    loading = false;
    response.fold(
            (error) {
              errorText = error.errorMessage;
              hasErrors = true;
              notifyListeners();
            },
            (r) => _router.go(Routes.accountSuccess)

    );

  }

}