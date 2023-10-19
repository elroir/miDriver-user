import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../repositories.dart';
import '../../domain/entities/transport_type.dart';

final getTransportTypesProvider = FutureProvider<List<TransportType>>(
        (ref) async {
      final result = await ref.read(Repositories.getTransportTypesUseCase).call();

      return result.fold(
              (failure) => throw failure,
              (transports) => transports
      );
    }

);