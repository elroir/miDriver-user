import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../repositories.dart';
import '../../domain/entities/service.dart';

final getCurrentServiceProvider = FutureProvider<Service>(
        (ref) async {
      final result = await ref.read(Repositories.getCurrentServiceUseCase).call();

      return result.fold(
              (failure) => throw failure,
              (currentService) => currentService
      );
    }

);