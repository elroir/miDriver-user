import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/http/entities/http_response.dart';
import '../entities/offer.dart';

abstract interface class OfferRepository {
  Future<Either<Failure, List<Offer>>> getOffers(int serviceId);
  Future<Either<Failure, HttpSuccess>> acceptOffer(int offerId);

}