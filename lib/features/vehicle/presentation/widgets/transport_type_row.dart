import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/widgets/network_or_svg_picture.dart';
import '../../../home/presentation/widgets/custom_error_widget.dart';
import '../provider/get_transport_types_provider.dart';

class TransportTypeRow extends ConsumerWidget {
  const TransportTypeRow({super.key});

  @override
  Widget build(BuildContext context,ref) {
    final transportTypes = ref.watch(getTransportTypesProvider);

    return transportTypes.when(
        data: (transports) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: transports.map((e) => Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white
            ),
            child: NetworkOrSvgPicture(
              imageUrl: e.imageUrl,
              height: 50,
            ),
          )).toList(),
        ),
        error: (error,stackTrace) => CustomErrorWidget(
          text: (error as Failure).errorMessage,
        ),
        loading: () => const Center(child: CircularProgressIndicator.adaptive(),)
    );
  }
}
