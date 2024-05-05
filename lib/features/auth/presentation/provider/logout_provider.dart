import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/router/router.dart';
import '../../../../repositories.dart';
import '../../domain/use_cases/sign_out_use_case.dart';

enum LogoutStatus{
  initial,
  loading,
  success,
  failure
}

final logoutProvider = StateNotifierProvider<LogoutNotifier,LogoutStatus>(
        (ref) => LogoutNotifier(ref.read(Repositories.logoutUseCase),ref.read(router))
);

class LogoutNotifier extends StateNotifier<LogoutStatus>{

  final SignOut _signOut;
  final GoRouter _router;

  LogoutNotifier(this._signOut, this._router) : super(LogoutStatus.initial);


  Future<void> call() async {
    state = LogoutStatus.loading;
    final signOutOrFailure = await _signOut();
    signOutOrFailure.fold(
            (error) => state = LogoutStatus.failure,
            (success) {
              state = LogoutStatus.success;
              _router.go(Routes.login);
            }
    );
  }



}