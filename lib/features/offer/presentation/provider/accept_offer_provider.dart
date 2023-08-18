
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/http/entities/http_post_status.dart';
import '../../../../repositories.dart';
import '../../domain/use_cases/accept_offer_use_case.dart';

final acceptOfferProvider = StateNotifierProvider<AcceptOfferProvider,HttpPostStatus>(
        (ref) {
      return AcceptOfferProvider(ref.read(Repositories.acceptOfferUseCase));
    }
);


class AcceptOfferProvider extends StateNotifier<HttpPostStatus>{

  final AcceptOffer _acceptOffer;
  AcceptOfferProvider(this._acceptOffer)  : super(HttpPostStatusNone());

  Future<void> acceptOffer(int offerId) async {
    state = HttpPostStatusLoading();
    final result = await _acceptOffer(offerId);
    state = result.fold(
            (error) => HttpPostStatusError(message:error.errorMessage),
            (success) => HttpPostStatusSuccess()
    );
  }

}