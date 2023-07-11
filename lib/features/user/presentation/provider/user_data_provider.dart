import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../repositories.dart';
import '../../domain/entities/user.dart';
import '../../domain/use_cases/get_user_data_use_case.dart';

final userDataProvider = StateNotifierProvider<UserDataNotifier,User?>(
        (ref) => UserDataNotifier(ref.read(Repositories.getUserDataUseCase))..init()
);


class UserDataNotifier extends StateNotifier<User?>{

  final GetUserData _getUserData;

  UserDataNotifier(this._getUserData) : super(null);

  Future<void> init() async {
      final userOrFail = await _getUserData();
      userOrFail.fold(
              (error) => state = null,
              (user) {
               state = user;
          }
      );

  }

}