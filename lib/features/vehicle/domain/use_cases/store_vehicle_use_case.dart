import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/http/entities/http_response.dart';
import '../../../../core/storage/secure_storage_repository.dart';
import '../entities/user_vehicle.dart';
import '../repositories/vehicle_repository.dart';

class StoreVehicle{

  final VehicleRepository _vehicleRepository;
  final SecureStorageRepository _storageRepository;

  StoreVehicle(this._vehicleRepository,this._storageRepository);

  Future<Either<Failure, HttpSuccess>>call(UserVehicle vehicle) async {
    final userId = await _storageRepository.getUserId();
    final vehicleOrFailure = await _vehicleRepository.storeVehicle(vehicle, userId!);
    return vehicleOrFailure;

  }

}