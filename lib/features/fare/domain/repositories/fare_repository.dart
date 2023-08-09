import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/fare.dart';

abstract interface class FareRepository{

  Future<Either<Failure,List<Fare>>> getFares();
  Either<Failure,List<Fare>> getCachedFares();


}