import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../repositories.dart';
import '../../../vehicle/domain/entities/transport_type.dart';
import '../../../vehicle/domain/use_cases/get_default_transport_type_use_case.dart';

final transportTypePickerProvider = StateNotifierProvider.autoDispose<TransportTypePickerProvider,TransportType?>((ref)  {

  return TransportTypePickerProvider(ref.read(Repositories.getDefaultTransportTypeUseCase))..init();
});

class TransportTypePickerProvider extends StateNotifier<TransportType?> {

  final GetDefaultTransportType _defaultTransportType;

  TransportTypePickerProvider(this._defaultTransportType) : super(null);

  void init(){
    state = _defaultTransportType()!;
  }

  void changeTransportType(TransportType transportType){
    state = transportType;
  }

}