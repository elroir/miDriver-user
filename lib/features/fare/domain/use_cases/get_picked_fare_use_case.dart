import '../entities/fare.dart';
import '../repositories/fare_repository.dart';

class GetPickedFare {
  final FareRepository _fareRepository;

  GetPickedFare(this._fareRepository);

  Fare? call() => _fareRepository.pickedFare;
}