import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/http/entities/http_post_status.dart';
import '../../../../repositories.dart';
import '../../domain/entities/user.dart';
import '../../domain/use_cases/get_user_data_use_case.dart';

final userDataProvider = StateNotifierProvider<UserDataNotifier,HttpPostStatus<User>>(
        (ref) => UserDataNotifier(ref.read(Repositories.getUserDataUseCase))..init()
);


class UserDataNotifier extends StateNotifier<HttpPostStatus<User>>{

  final GetUserData _getUserData;

  UserDataNotifier(this._getUserData) : super(HttpPostStatusNone());

  Future<void> init() async {
      state = HttpPostStatusLoading();
      final userOrFail = await _getUserData();
      state = userOrFail.fold(
              (error) {
                if(error is AuthFailure){
                 return HttpPostStatusAuthorization(message: error.errorMessage);
                }
                return HttpPostStatusError(message: error.errorMessage);

              },
              (user) => HttpPostStatusSuccess(data: user)

      );

  }

}