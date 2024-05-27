import '../entities/transport_type.dart';
import '../repositories/vehicle_repository.dart';

class GetDefaultTransportType{
  final VehicleRepository _vehicleRepository;

  GetDefaultTransportType(this._vehicleRepository);

  TransportType? call() => _vehicleRepository.getDefaultTransportType();
}