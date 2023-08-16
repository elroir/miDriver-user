import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../repositories.dart';
import '../../domain/entities/offer.dart';

final getOffersProvider = FutureProvider<List<Offer>>(
        (ref) async {
      final result = await ref.read(Repositories.getOffersUseCase).call();

      return result.fold(
              (failure) => throw failure,
              (offers) => offers
      );
    }

);