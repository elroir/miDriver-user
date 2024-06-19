import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../repositories.dart';
import '../../domain/entities/address.dart';

final pickedAddressProvider = StateProvider.autoDispose<Address?>(
        (ref) {
          final addressOrFail = ref.read(Repositories.getDefaultAddressUseCase).call();
          return addressOrFail.getRight().toNullable();
        }
);
