import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/http/entities/http_response.dart';
import '../repositories/address_repository.dart';

class DeleteAddress{
  final AddressRepository _addressRepository;

  DeleteAddress(this._addressRepository);

  Future<Either<Failure,HttpSuccess>> call(int addressId) async {
    return await _addressRepository.deleteAddress(addressId);
  }
}