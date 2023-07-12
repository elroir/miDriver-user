import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../repositories.dart';
import '../../domain/entities/car_make.dart';

final getCarMakesProvider = FutureProvider<List<CarMake>>(
        (ref) async {
      final result = await ref.read(Repositories.getCarMakesUseCase).call();

      return result.fold(
              (failure) => throw failure,
              (makes) {
                makes.sort((a, b) => a.makeName.compareTo(b.makeName));
                return makes;
              }
      );
    }

);