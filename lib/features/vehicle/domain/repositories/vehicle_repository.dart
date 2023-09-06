import 'package:fpdart/fpdart.dart';
import '../entities/car_make.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/http/entities/http_response.dart';
import '../entities/user_vehicle.dart';

abstract interface class VehicleRepository{
  Future<Either<Failure, List<CarMake>>> getCarMakes();
  Future<Either<Failure, HttpSuccess>> storeVehicle(UserVehicle vehicle,String userId);
  Future<Either<Failure, HttpSuccess>> deleteVehicle(int vehicleId);

  Future<Either<Failure, List<UserVehicle>>> getUserVehicles();

  void saveTransmissionType(String transmissionType);
  void saveMakeId(int makeId);

}