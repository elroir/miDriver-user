import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/widgets/network_or_svg_picture.dart';
import '../../../home/presentation/widgets/custom_error_widget.dart';
import '../../../service/presentation/provider/default_service_provider.dart';
import '../provider/get_transport_types_provider.dart';

class TransportTypeRow extends ConsumerWidget {
  const TransportTypeRow({super.key});

  @override
  Widget build(BuildContext context,ref) {
    final transportTypes = ref.watch(getTransportTypesProvider);

    return transportTypes.when(
        data: (transports) {
          ref.read(defaultServiceProvider.notifier).setTransportType(transports);

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: transports.map((e) => GestureDetector(
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: e.defaultTransportType ? Border.all(color: Colors.green,width: 5) : null
                ),
                child: NetworkOrSvgPicture(
                  imageUrl: e.imageUrl,
                  height: e.defaultTransportType ? 60 : 50,
                ),
              ),
            )).toList(),
          );
        },
        error: (error,stackTrace) => CustomErrorWidget(
          text: (error as Failure).errorMessage,
        ),
        loading: () => const Center(child: CircularProgressIndicator.adaptive(),)
    );
  }
}
