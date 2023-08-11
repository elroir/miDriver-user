import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../repositories.dart';
import '../../../fare/domain/entities/fare.dart';

final serviceFareProvider = FutureProvider.family.autoDispose<Fare?,int>(
        (ref,fareId) async {
      final response = await ref.read(Repositories.getCachedFaresUseCase).call();
      return response.fold(
              (l) => null,
              (fares) {
            Fare? fare;
            if(fares.any((e) => e.id== fareId)){
              fare = fares.firstWhere((e) => e.id == fareId);
              ref.read(Repositories.pickFareUseCase).call(fare);
            }
            return fare;
          }
      );

    }

);