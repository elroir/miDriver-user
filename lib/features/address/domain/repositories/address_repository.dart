import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/address.dart';

abstract interface class AddressRepository{

  Future<Either<Failure,List<Address>>> getAddresses();
}