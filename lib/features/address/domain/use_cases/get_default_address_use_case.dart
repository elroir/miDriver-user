import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/address.dart';
import '../repositories/address_repository.dart';

class GetDefaultAddress {
  final AddressRepository _addressRepository;

  GetDefaultAddress(this._addressRepository);

  Either<Failure,Address> call()  {
    return _addressRepository.getDefaultAddress();
  }

}