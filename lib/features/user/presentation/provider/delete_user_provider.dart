import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/http/entities/http_post_status.dart';
import '../../../../core/router/router.dart';
import '../../../../repositories.dart';
import '../../domain/use_cases/delete_user_use_case.dart';

final deleteUserProvider = StateNotifierProvider<DeleteUserNotifier,HttpPostStatus>(
        (ref) => DeleteUserNotifier(ref.read(Repositories.deleteUserUseCase),ref.read(router))
);


class DeleteUserNotifier extends StateNotifier<HttpPostStatus>{

  final DeleteUser _deleteUser;
  final GoRouter _router;

  DeleteUserNotifier(this._deleteUser, this._router) : super(HttpPostStatusNone());


  void openDialog(){
    state = HttpPostStatusInProgress();
  }

  Future<void> deleteUser() async {
    state = HttpPostStatusLoading();
    final userOrFail = await _deleteUser();
    userOrFail.fold(
            (error) => state = HttpPostStatusError(message: error.errorMessage),
            (user) {
                    state = HttpPostStatusSuccess();
                    _router.go(Routes.login);
              }
    );

  }

}