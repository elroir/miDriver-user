import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../../repositories.dart';

final locationStateProvider = StreamProvider.autoDispose<LatLng>((ref){


  return ref.read(Repositories.getLocationStreamUseCase).call().map((position){
    ref.read(locationProvider.notifier).state = position;
    return position;
  });
});

final locationProvider = StateProvider<LatLng>((ref){
  return const LatLng(-17.782939, -63.180844);
});