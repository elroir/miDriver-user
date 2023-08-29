import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/http/entities/http_post_status.dart';
import '../../../../core/url_launcher/use_cases/open_url_use_case.dart';
import '../../../../repositories.dart';

final openUrlProvider = StateNotifierProvider<OpenUrlNotifier,HttpPostStatus>(
        (ref) => OpenUrlNotifier( ref.read(Repositories.openUrlUseCase))
);

class OpenUrlNotifier extends StateNotifier<HttpPostStatus>{

  final OpenUrl _openUrl;

  OpenUrlNotifier(this._openUrl) : super(HttpPostStatusNone());


  Future<void> openUrl(String url) async {

    await _openUrl(url);

    state = HttpPostStatusSuccess();

  }



}