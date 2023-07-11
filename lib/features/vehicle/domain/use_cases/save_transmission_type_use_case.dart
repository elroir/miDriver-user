import '../repositories/vehicle_repository.dart';

class SaveTransmissionType{

  final VehicleRepository _vehicleRepository;

  SaveTransmissionType(this._vehicleRepository);

  void call(String transmissionType) {
    _vehicleRepository.saveTransmissionType(transmissionType);
  }

}