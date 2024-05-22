import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/location/location_repository.dart';
import '../../../map/domain/entities/direction.dart';
import '../../../map/domain/repositories/map_repository.dart';
import '../repositories/address_repository.dart';

class GetAddressDirection {
  final LocationRepository _locationRepository;
  final AddressRepository _addressRepository;
  final MapRepository _mapRepository;

  GetAddressDirection(this._locationRepository,this._addressRepository,this._mapRepository);

  Future<Either<Failure,Direction>> call() async {
    final permissionOrFailure = await _locationRepository.requestLocationPermission();
    return permissionOrFailure.fold(
            (error) => Left(error),
            (ok) async {
          final origin = await _locationRepository.getLocation();
          _mapRepository.pickLocation(origin);
          final addressOrFailure = _addressRepository.getDefaultAddress();
          return addressOrFailure.fold(
                  (error) async => Left(error),
                  (address) async {
                    final directionsOrFailure = await _mapRepository.getDirections(address.location);
                    return directionsOrFailure;
                  }
          );

        }
    );
  }
}