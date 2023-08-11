import '../entities/fare.dart';
import '../repositories/fare_repository.dart';

class PickFare {
  final FareRepository _fareRepository;

  PickFare(this._fareRepository);

  void call(Fare? fare) => _fareRepository.pickFare(fare);
}