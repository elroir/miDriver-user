
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../repositories.dart';
import '../../domain/entities/user_vehicle.dart';

final getVehiclesProvider = FutureProvider<List<UserVehicle>>(
        (ref) async {
      final result = await ref.read(Repositories.getUserVehiclesUseCase).call();
      return result.fold(
              (failure) => throw failure,
              (vehicles) => vehicles
      );
    }

);