import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../repositories.dart';
import '../../domain/use_cases/request_location_permission_use_case.dart';

final locationPermissionProvider = StateNotifierProvider<LocationPermissionNotifier,bool>(
        (ref) =>  LocationPermissionNotifier(ref.read(Repositories.locationPermissionUseCase))..init()
);


class LocationPermissionNotifier extends StateNotifier<bool>{

  final RequestLocationPermission _locationPermission;

  LocationPermissionNotifier(this._locationPermission) : super(false);

  Future<void> init() async {
    final permission = await _locationPermission();
    permission.fold(
      (error) => state = false,
      (ok) => state = true
    );

  }

}