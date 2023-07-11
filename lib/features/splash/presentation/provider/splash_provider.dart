import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../repositories.dart';
import '../../../auth/domain/entities/auth_status.dart';
import '../../domain/use_cases/initial_screen_use_case.dart';

final splashProvider = StateNotifierProvider<SplashNotifier,AuthStatus>(
        (ref) => SplashNotifier(ref.read(Repositories.splashUseCase))..init()
);


class SplashNotifier extends StateNotifier<AuthStatus>{

  final GetInitialPage _getInitialPage;

  SplashNotifier(this._getInitialPage) : super(AuthStatus.none);

  Future<void> init() async {
    final authStatus = await _getInitialPage();
    state = authStatus;
  }

}