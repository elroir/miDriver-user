import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/resources/values_manager.dart';
import '../../../../core/router/router.dart';
import '../../../map/presentation/provider/current_location_provider.dart';
import '../../../map/presentation/provider/pick_location_provider.dart';
import '../../../map/presentation/widgets/mapbox_attribution.dart';
import '../widgets/address_form.dart';

class AddressFormPage extends ConsumerWidget {
  const AddressFormPage({super.key});

  @override
  Widget build(BuildContext context,ref) {
    final location = ref.watch(locationProvider);
    final locationSelection = ref.watch(pickLocationProvider);

    return PopScope(
      canPop: false,
      onPopInvoked: (canPop) {
        ref.read(pickLocationProvider.notifier).clearOrigin();
        context.pop();
      },
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 80,
          forceMaterialTransparency: true,
          leading: const CircleAvatar(
            backgroundColor: Colors.white,
              child: BackButton(color: Colors.black54)
          ),
        ),
        extendBodyBehindAppBar: true,
        body: SafeArea(
          bottom: true,
          top: false,
          child: Column(
            children: [
              Expanded(
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: locationSelection.origin ?? location,
                    initialZoom: 12.0,
                    maxZoom: 22,
                    onTap: (_, location) => ref.read(pickLocationProvider.notifier).pickOrigin(location)
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: MapStrings.tileUrl,
                    ),
                    MarkerLayer(
                        markers: [
                          if(locationSelection.origin!=null)
                            Marker(
                                point: locationSelection.origin!,
                                height: 140,
                                width: 120,
                                child: const Icon(Icons.location_on,color: Colors.red,size: 40)
                            ),
                        ]
                    ),
                    const MapBoxAttribution()
                  ],
                ),
              ),
              const AddressForm()
            ],
          ),
        )
      ),
    );
  }
}
