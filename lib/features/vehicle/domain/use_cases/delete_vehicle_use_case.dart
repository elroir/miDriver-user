import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/http/entities/http_response.dart';
import '../repositories/vehicle_repository.dart';

class DeleteVehicle {
  final VehicleRepository _vehicleRepository;

  DeleteVehicle(this._vehicleRepository);

  Future<Either<Failure, HttpSuccess>> call(int id) async {
    return await _vehicleRepository.deleteVehicle(id);
  }
}