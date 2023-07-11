import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/router/router.dart';
import '../../../../repositories.dart';
import '../../domain/entities/car_make.dart';
import '../../domain/use_cases/save_make_use_case.dart';

final makeProvider = StateNotifierProvider.autoDispose<MakeNotifier,CarMake?>(
        (ref) => MakeNotifier(ref.read(Repositories.saveMakeIdUseCase),ref.read(router))
);


class MakeNotifier extends StateNotifier<CarMake?> {

  final SaveMakeId _saveMakeId;
  final GoRouter _router;

  MakeNotifier(this._saveMakeId,this._router) : super(null);

  void pickMake(CarMake carMake){
    state = carMake;
    _saveMakeId(carMake.id);
    _router.pop();
  }

}