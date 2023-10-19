import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/transport_type.dart';
import '../repositories/vehicle_repository.dart';

class GetTransportTypes{

  final VehicleRepository _vehicleRepository;

  GetTransportTypes(this._vehicleRepository);

  Future<Either<Failure, List<TransportType>>>call() async {
    final vehiclesOrFailure = await _vehicleRepository.getTransportTypes();
    return vehiclesOrFailure;

  }

}