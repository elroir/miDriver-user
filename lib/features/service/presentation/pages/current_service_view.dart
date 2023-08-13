import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/http/entities/http_post_status.dart';
import '../provider/cancel_service_provider.dart';
import '../provider/get_current_service_provider.dart';

class CurrentServiceView extends ConsumerWidget {
  const CurrentServiceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,ref) {
    ref.listen(cancelServiceProvider, (previous, next) {
      if(next is HttpPostStatusSuccess){
        ref.invalidate(getCurrentServiceProvider);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Servicio cancelado'),
          )
        );
      }
    });
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: ElevatedButton(
            onPressed: () => ref.read(cancelServiceProvider.notifier).cancelService(),
              child: const Text('Cancelar')
          ),
        )

      ],
    );
  }
}
