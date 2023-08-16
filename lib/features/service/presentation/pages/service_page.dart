import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failures.dart';

import '../../../home/presentation/pages/error_view.dart';
import '../provider/get_current_service_provider.dart';
import 'current_service_view.dart';
import 'no_service_view.dart';

class ServicePage extends ConsumerWidget {
  const ServicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,ref) {
    final currentService = ref.watch(getCurrentServiceProvider);

    return Scaffold(
      body: currentService.when(
        skipLoadingOnRefresh: false,
          data: (currentService) => const CurrentServiceView(),
          error: (error,_) {
            if(error is NoServiceFailure){
              return const NoServiceView();
            }
            return ErrorView(onTap: ()=> ref.invalidate(getCurrentServiceProvider));
          },
          loading: () => const Center(child: CircularProgressIndicator.adaptive(),)
      ),
    );
  }
}
