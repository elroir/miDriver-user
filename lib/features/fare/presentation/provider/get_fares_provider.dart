import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../repositories.dart';
import '../../domain/entities/fare.dart';

final getFaresProvider = FutureProvider<List<Fare>>(
        (ref) async {
      final result = await ref.read(Repositories.getFaresUseCase).call();

      return result.fold(
              (failure) => throw failure,
              (fares) {
            return fares;
          }
      );
    }

);