import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/resources/strings_manager.dart';
import '../../../../repositories.dart';
import '../../domain/use_cases/save_transmission_type_use_case.dart';


final transmissionTypeProvider = StateNotifierProvider<TransmissionTypeNotifier,String>(
        (ref) => TransmissionTypeNotifier(ref.read(Repositories.saveTransmissionTypeUseCase))
);


class TransmissionTypeNotifier extends StateNotifier<String> {

  final SaveTransmissionType _saveTransmissionType;

  TransmissionTypeNotifier(this._saveTransmissionType) : super(AppStrings.automatic);

  void changeTransmissionField(String value){
    state = value;
    _saveTransmissionType(value);
  }

}