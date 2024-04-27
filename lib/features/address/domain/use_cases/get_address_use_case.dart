import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/address.dart';
import '../repositories/address_repository.dart';

class GetAddress {
  final AddressRepository _addressRepository;

  GetAddress(this._addressRepository);

  Either<Failure,Address> call(int addressId)  {
    return _addressRepository.getAddressById(addressId);
  }

}