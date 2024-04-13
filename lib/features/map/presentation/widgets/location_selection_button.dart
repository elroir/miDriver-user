import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/http/entities/http_post_status.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/widgets/loading_button.dart';
import '../../../service/presentation/provider/service_form_provider.dart';
import '../provider/direction_provider.dart';
import '../provider/pick_location_provider.dart';

class LocationSelectionButton extends ConsumerWidget {
  const LocationSelectionButton({super.key});

  @override
  Widget build(BuildContext context,ref) {
    final locationSelection = ref.watch(pickLocationProvider);
    final directions = ref.watch(directionProvider);

    if(locationSelection is LocationSelectionNone){
      return FractionallySizedBox(
        widthFactor: 0.9,
        child: ElevatedButton(
            onPressed: () {},
            child: const Text(AppStrings.pickOrigin)
        ),
      );
    }

    if(locationSelection is LocationSelectionOrigin){
      return FractionallySizedBox(
        widthFactor: 0.9,
        child: ElevatedButton(
            onPressed: () {},
            child: const Text(AppStrings.pickDestination)
        ),
      );
    }

    if(locationSelection is LocationSelectionDestination){
      return LoadingButton(
          widthFactor: 0.9,
          fixedHeight: 46,
          isLoading: directions is HttpPostStatusLoading,
          onPressed: () => ref.read(directionProvider.notifier).getDirections(locationSelection.destination!),
          buttonText: AppStrings.confirm
      );
    }

    return LoadingButton(
        widthFactor: 0.9,
        fixedHeight: 46,
        isLoading: directions is HttpPostStatusLoading,
        onPressed: () => ref.read(serviceFormProvider.notifier).storeService(),
        buttonText: AppStrings.requestDriver
    );

  }
}
