import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/fare.dart';
import '../repositories/fare_repository.dart';

class GetCachedFares {
  final FareRepository _fareRepository;

  GetCachedFares(this._fareRepository);

  Future<Either<Failure,List<Fare>>> call() async {
    final cachedOrFailure = _fareRepository.getCachedFares();
    return cachedOrFailure.fold(
            (notCached) async {
              return await _fareRepository.getFares();
            },
            (cached) => Right(cached)
    );
  }
}