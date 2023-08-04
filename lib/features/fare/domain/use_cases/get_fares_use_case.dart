import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/fare.dart';
import '../repositories/fare_repository.dart';

class GetFares {
  final FareRepository _fareRepository;

  GetFares(this._fareRepository);

  Future<Either<Failure,List<Fare>>> call() async {
    return await _fareRepository.getFares();
  }
}