import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/http/entities/http_post_status.dart';
import '../../../../repositories.dart';
import '../../domain/use_cases/update_user_push_token_use_case.dart';

final pushTokenProvider = StateNotifierProvider<PushTokenNotifier,HttpPostStatus>(
        (ref) => PushTokenNotifier(ref.read(Repositories.updateUserTokenUseCase))..init()
);


class PushTokenNotifier extends StateNotifier<HttpPostStatus>{

  final UpdateUserToken _updateUserToken;

  PushTokenNotifier(this._updateUserToken) : super(HttpPostStatusNone());

  Future<void> init() async {
    if(state is HttpPostStatusNone || state is HttpPostStatusError){
      final updatePushOrFail = await _updateUserToken();
      updatePushOrFail.fold(
              (error) => state = HttpPostStatusError(message: error.errorMessage),
              (success) {
            state = HttpPostStatusSuccess();
          }
      );
    }

  }

}