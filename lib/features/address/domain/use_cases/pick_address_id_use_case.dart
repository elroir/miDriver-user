
import '../repositories/address_repository.dart';

class PickAddressId {
  final AddressRepository _addressRepository;

  PickAddressId(this._addressRepository);

  void call(int addressId)  {
    return _addressRepository.pickAddressId(addressId);
  }

}