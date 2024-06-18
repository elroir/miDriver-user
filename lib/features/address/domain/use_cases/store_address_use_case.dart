import 'package:fpdart/fpdart.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/http/entities/http_response.dart';
import '../../../../core/storage/secure_storage_repository.dart';
import '../entities/address.dart';
import '../repositories/address_repository.dart';

class StoreOrEditAddress{
  final AddressRepository _addressRepository;
  final SecureStorageRepository _storageRepository;

  StoreOrEditAddress(this._addressRepository,this._storageRepository);

  Future<Either<Failure,HttpSuccess>> call({required String title,required String address,required LatLng location,bool defaultAddress = true,int id = 0}) async {
    final userId = await _storageRepository.getUserId();
    if(userId == null) return Left(CacheFailure());
    return await _addressRepository.storeOrEditAddress(Address(
      id: id,
      title: title,
      address: address,
      location: location,
      userId: userId,
      defaultAddress: defaultAddress
    ));
  }
}