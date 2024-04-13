import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/http/entities/http_post_status.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/widgets/error_text_widget.dart';
import '../../../../core/widgets/loading_button.dart';
import '../../../auth/presentation/widgets/background_logo_widget.dart';
import '../provider/vehicle_provider.dart';
import '../widgets/car_make_picker.dart';
import '../widgets/transmission_type_picker.dart';

class VehicleFormPage extends ConsumerWidget {
  const VehicleFormPage({super.key});

  @override
  Widget build(BuildContext context,ref) {

    final vehicleForm = ref.watch(vehicleProvider);
    
    return Scaffold(
      appBar: AppBar(),
      extendBodyBehindAppBar: true,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          const BackGroundLogoWidget(),
          Container(
            constraints: const BoxConstraints(
                minHeight: 300,
                maxHeight: 600,
                maxWidth: 600
            ),
            margin: const EdgeInsets.only(bottom: 80),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: ref.read(vehicleProvider.notifier).key,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppStrings.carRegister,style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: 15),
                        const CarMakePicker(),
                        const SizedBox(height: 15),
                        TextFormField(
                            onSaved: ref.read(vehicleProvider.notifier).saveModelField,
                            validator: ref.read(vehicleProvider.notifier).validateModel,
                            decoration: const InputDecoration(
                                labelText: AppStrings.carModel
                            )
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                            onSaved: ref.read(vehicleProvider.notifier).saveYearField,
                            validator: ref.read(vehicleProvider.notifier).validateYear,
                            keyboardType: const TextInputType.numberWithOptions(decimal: false,signed: false),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(4),
                            ],
                            decoration: const InputDecoration(
                                labelText: AppStrings.carYear
                            )
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                            onSaved: ref.read(vehicleProvider.notifier).savePlateField,
                            validator: ref.read(vehicleProvider.notifier).validatePlate,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(7),
                            ],
                            decoration: const InputDecoration(
                                labelText: AppStrings.carPlate
                            )
                        ),
                        const SizedBox(height: 15),
                        Text(AppStrings.carTransmission,style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 15),
                        const TransmissionTypePicker(),
                        const SizedBox(height: 15),
                        if(vehicleForm is HttpPostStatusError)
                        ErrorTextWidget(errorText: vehicleForm.message),
                        Center(
                          child: LoadingButton(
                              onPressed: () => ref.read(vehicleProvider.notifier).storeVehicle(),
                              isLoading: vehicleForm is HttpPostStatusLoading,
                              buttonText: AppStrings.carRegister
                          )
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
