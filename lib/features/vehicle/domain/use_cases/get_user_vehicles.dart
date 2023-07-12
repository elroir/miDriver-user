import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/user_vehicle.dart';
import '../repositories/vehicle_repository.dart';

class GetUserVehicles{

  final VehicleRepository _vehicleRepository;

  GetUserVehicles(this._vehicleRepository);

  Future<Either<Failure, List<UserVehicle>>>call() async {

    final vehiclesOrFailure = await _vehicleRepository.getUserVehicles();
    return vehiclesOrFailure;

  }

}