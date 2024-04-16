import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/http/entities/http_response.dart';
import '../entities/address.dart';

abstract interface class AddressRepository{

  Future<Either<Failure,List<Address>>> getAddresses();
  Future<Either<Failure,HttpSuccess>> storeAddress(Address address);
  Future<Either<Failure,HttpSuccess>> deleteAddress(int addressId);
}