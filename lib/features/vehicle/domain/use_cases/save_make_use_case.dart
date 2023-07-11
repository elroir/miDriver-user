import '../repositories/vehicle_repository.dart';

class SaveMakeId{

  final VehicleRepository _vehicleRepository;

  SaveMakeId(this._vehicleRepository);

  void call(int makeId) {
    _vehicleRepository.saveMakeId(makeId);
  }

}