import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/http/entities/http_post_status.dart';
import '../../../../repositories.dart';
import '../../domain/use_cases/cancel_service_use_case.dart';

final cancelServiceProvider = StateNotifierProvider<CancelServiceProvider,HttpPostStatus>(
        (ref) {
      return CancelServiceProvider(ref.read(Repositories.cancelCurrentServiceUseCase));
    }
);


class CancelServiceProvider extends StateNotifier<HttpPostStatus>{

  final CancelService _cancelService;
  CancelServiceProvider(this._cancelService)  : super(HttpPostStatusNone());

  Future<void> cancelService() async {
    state = HttpPostStatusLoading();
    final result = await _cancelService();
    state = result.fold(
            (error) => HttpPostStatusError(message:error.errorMessage),
            (success) => HttpPostStatusSuccess()
    );
  }

}