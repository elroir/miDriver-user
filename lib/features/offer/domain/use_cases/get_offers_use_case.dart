import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../service/domain/repositories/service_repository.dart';
import '../entities/offer.dart';
import '../repositories/offer_repository.dart';

class GetOffers{
  final OfferRepository _offerRepository;
  final ServiceRepository _serviceRepository;

  GetOffers(this._offerRepository, this._serviceRepository);

  Future<Either<Failure,List<Offer>>> call() async {
    final serviceId = _serviceRepository.currentServiceId;
    return await _offerRepository.getOffers(serviceId);
  }
}