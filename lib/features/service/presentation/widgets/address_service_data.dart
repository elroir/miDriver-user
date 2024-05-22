import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/http/entities/http_post_status.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/widgets/loading_button.dart';
import '../../../address/presentation/provider/address_direction_provider.dart';
import '../../../home/presentation/provider/navigation_bar_provider.dart';
import '../provider/default_service_provider.dart';
import '../provider/get_current_service_provider.dart';

class AddressServiceData extends ConsumerWidget {
  const AddressServiceData({super.key});

  @override
  Widget build(BuildContext context,ref) {
    final price = ref.watch(addressDirectionProvider);
    final serviceProvider = ref.watch(defaultServiceProvider);

    ref.listen(addressDirectionProvider, (previous, next) {
      if(next is HttpPostStatusSuccess){
        ref.read(defaultServiceProvider.notifier).setPriceAndDistance(next.data!.$1, next.data!.$2.distanceInMeters);
      }
    });

    ref.listen(defaultServiceProvider, (previous, next) {
      if(next is HttpPostStatusSuccess){
        ref.invalidate(getCurrentServiceProvider);
        ref.read(navigationBarProvider.notifier).onChangeTab(1);
      }
    });

    if(price is HttpPostStatusSuccess){
      return Column(
        children: [
          Text(price.data!.$1.toStringAsFixed(2)),
          const SizedBox(height: 10),
          LoadingButton(
            onPressed: () => ref.read(defaultServiceProvider.notifier).storeService(),
            buttonText: AppStrings.requestDriver,
            isLoading: serviceProvider is HttpPostStatusLoading,
          ),
        ],
      );
    }
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}
