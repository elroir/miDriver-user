import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/car_make.dart';
import '../repositories/vehicle_repository.dart';

class GetCarMakes{

  final VehicleRepository _vehicleRepository;

  GetCarMakes(this._vehicleRepository);

  Future<Either<Failure, List<CarMake>>>call() async {
    final vehiclesOrFailure = await _vehicleRepository.getCarMakes();
    return vehiclesOrFailure;

  }

}