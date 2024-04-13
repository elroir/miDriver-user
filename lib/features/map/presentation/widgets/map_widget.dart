import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/strings_manager.dart';

import '../../../../core/resources/values_manager.dart';
import '../provider/current_location_provider.dart';
import '../provider/map_controller_provider.dart';
import '../provider/pick_location_provider.dart';
import '../provider/polyline_provider.dart';
import 'flag_marker.dart';

class MapWidget extends ConsumerWidget {

  const MapWidget({super.key});

  @override
  Widget build(BuildContext context,ref) {
    final locationSelection = ref.watch(pickLocationProvider);
    final polyline = ref.watch(polylineProvider);
    final location = ref.watch(locationProvider);
    final mapController = ref.watch(mapControllerProvider);

    ref.read(locationStateProvider);


    return Stack(
      children: [
        FlutterMap(
          mapController: mapController,
          options: MapOptions(
              initialCenter: location,
              initialZoom: 12.0,
              maxZoom: 22,
              minZoom: 6,
              onTap: (_, location) => ref.read(pickLocationProvider.notifier).pickLocation(location)
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
                        child: FlagMarker(
                          text: AppStrings.pickupPlace,
                          color: Colors.white.withOpacity(0.9),
                          textStyle: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 12,color: Colors.black)
                        )
                    ),
                  if(locationSelection.destination!=null)
                    Marker(
                        point: locationSelection.destination!,
                        height: 140,
                        width: 120,
                        child: FlagMarker(text: AppStrings.destinationPlace,textStyle: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 12,color: Colors.white),)
                    ),
                ]
            ),
            if(polyline!=null)
              PolylineLayer(
                polylines: [
                  polyline
                ],
              ),
            CurrentLocationLayer(),
            RichAttributionWidget(
              alignment: AttributionAlignment.bottomLeft,
                showFlutterMapAttribution: false,
                attributions: [
                  LogoSourceAttribution(
                      SvgPicture.asset(AssetsManager.mapboxIconBlack,alignment: Alignment.centerLeft,),
                    height: 50,
                  ),
                ]
            )
          ],
        ),
        SafeArea(
          bottom: true,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 80,right: 15),
            child: Align(
              alignment: Alignment.bottomRight,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                    onPressed: () => mapController.move(location, 15),
                    icon: const Icon(Icons.my_location,color: Colors.black,)
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
