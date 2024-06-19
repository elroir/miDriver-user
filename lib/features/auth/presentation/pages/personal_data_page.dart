import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/resources/strings_manager.dart';
import '../../../../core/widgets/error_text_widget.dart';
import '../provider/personal_data_provider.dart';
import '../widgets/background_logo_widget.dart';

class PersonalDataPage extends ConsumerWidget {

  const PersonalDataPage({super.key});

  @override
  Widget build(BuildContext context,ref) {
    final personalData = ref.watch(personalDataProvider);
    return Scaffold(
      appBar: AppBar(),
      extendBodyBehindAppBar: true,
      body: Stack(
        alignment: Alignment.center,
        children: [
          const BackGroundLogoWidget(),
          Container(
            constraints: const BoxConstraints(
              minHeight: 300,
              maxHeight: 600,
              maxWidth: 600
            ),
            margin: const EdgeInsets.only(bottom: 80),
            alignment: Alignment.bottomCenter,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                child: (personalData.loading)
                    ? const Center(child: CircularProgressIndicator.adaptive())
                    : SingleChildScrollView(
                  child: Form(
                    key: personalData.key,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 15),
                        TextFormField(
                            onSaved: personalData.saveNameField,
                            validator: personalData.validateNotEmpty,
                            decoration: const InputDecoration(
                                labelText: AppStrings.nameField
                            )
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          onSaved: personalData.saveLastNameField,
                          validator: personalData.validateNotEmpty,
                          decoration: const InputDecoration(
                              labelText: AppStrings.lastNameField
                          ),
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          onSaved: personalData.savePhoneNumberField,
                          validator: personalData.validatePhone,
                          keyboardType: const TextInputType.numberWithOptions(signed: false,decimal: false),
                          decoration: const InputDecoration(
                              labelText: AppStrings.phoneField
                          ),
                        ),
                        if(personalData.hasErrors)
                        ErrorTextWidget(errorText: personalData.errorText),
                        const SizedBox(height: 30),
                        FractionallySizedBox(
                          widthFactor: 0.9,
                          child: ElevatedButton(
                              onPressed: () => personalData.register(),
                              child: Text(AppStrings.finishRegister.toUpperCase())
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              )
            ),
          )
        ],
      ),
    );
  }
}
