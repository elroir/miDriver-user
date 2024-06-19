import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/resources/values_manager.dart';
import '../../../../core/router/router.dart';
import '../../../map/presentation/provider/current_location_provider.dart';
import '../../../map/presentation/provider/map_controller_provider.dart';
import '../../../map/presentation/provider/pick_location_provider.dart';
import '../../../map/presentation/widgets/mapbox_attribution.dart';
import '../widgets/address_form.dart';

class AddressFormPage extends ConsumerWidget {
  const AddressFormPage({super.key});

  @override
  Widget build(BuildContext context,ref) {
    final location = ref.watch(locationProvider);
    final locationSelection = ref.watch(pickLocationProvider);
    final mapController = ref.watch(mapControllerProvider);

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
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: FlutterMap(
                      mapController: mapController,
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
                        CurrentLocationLayer(),
                        const MapBoxAttribution()
                      ],
                    ),
                  ),

                  const AddressForm()
                ],
              ),
              SafeArea(
                bottom: true,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 80,right: 15),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                          onPressed: () => mapController.move(location, 15),
                          icon: const Icon(Icons.my_location,color: Colors.black,)
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
