import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/address.dart';
import '../repositories/address_repository.dart';

class GetAddresses{
  final AddressRepository _addressRepository;

  GetAddresses(this._addressRepository);

  Future<Either<Failure,List<Address>>> call() async{
    return await _addressRepository.getAddresses();
  }

}