import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/http/entities/http_response.dart';
import '../repositories/offer_repository.dart';

class AcceptOffer{
  final OfferRepository _offerRepository;

  AcceptOffer(this._offerRepository);

  Future<Either<Failure, HttpSuccess>> call(int offerId) async {
    return await _offerRepository.acceptOffer(offerId);
  }
}