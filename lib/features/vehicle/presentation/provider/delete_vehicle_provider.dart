

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/http/entities/http_post_status.dart';
import '../../../../repositories.dart';
import '../../domain/use_cases/delete_vehicle_use_case.dart';

final deleteVehicleProvider = StateNotifierProvider<DeleteVehicleProvider,HttpPostStatus>(
        (ref) => DeleteVehicleProvider(ref.read(Repositories.deleteVehicleUseCase))
);


class DeleteVehicleProvider extends StateNotifier<HttpPostStatus> {

  final DeleteVehicle _deleteVehicle;
  int? _vehicleId;

  DeleteVehicleProvider(this._deleteVehicle) : super(HttpPostStatusNone());

  void openDialog(int vehicleId){
    _vehicleId = vehicleId;
    state = HttpPostStatusInProgress();
  }

  Future<void> deleteVehicle() async {
    if(_vehicleId == null) return ;
    state = HttpPostStatusLoading();
    final result = await _deleteVehicle(_vehicleId!);
    state = result.fold(
            (error) => HttpPostStatusError(message: error.errorMessage),
            (success) => HttpPostStatusSuccess()
    );
  }

}