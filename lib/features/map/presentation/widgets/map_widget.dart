import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/resources/strings_manager.dart';

import '../provider/current_location_provider.dart';
import '../provider/map_controller_provider.dart';
import '../provider/pick_location_provider.dart';
import '../provider/polyline_provider.dart';
import 'flag_marker.dart';

class MapWidget extends ConsumerWidget {

  const MapWidget({Key? key}) : super(key: key);

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
              center: const LatLng(-17.7853232, -63.1884931),
              zoom: 12.0,
              maxZoom: 18,
              minZoom: 6,
              onTap: (_, location) => ref.read(pickLocationProvider.notifier).pickLocation(location)
          ),
          nonRotatedChildren: [
            SimpleAttributionWidget(source: const Text(AppStrings.mapAttribution),backgroundColor: Colors.white.withOpacity(0.2),)
          ],
          children: [
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: const ['a', 'b', 'c'],
            ),
            MarkerLayer(
                markers: [
                  if(locationSelection.origin!=null)
                    Marker(
                        point: locationSelection.origin!,
                        height: 140,
                        width: 120,
                        builder: (context) => FlagMarker(
                          text: AppStrings.pickupPlace,
                          color: Colors.white.withOpacity(0.9),
                          textStyle: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 12)
                        )
                    ),
                  if(locationSelection.destination!=null)
                    Marker(
                        point: locationSelection.destination!,
                        height: 140,
                        width: 120,
                        builder: (context) => FlagMarker(text: AppStrings.destinationPlace,textStyle: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 12,color: Colors.white),)
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

          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 80,right: 15),
          child: Align(
            alignment: Alignment.bottomRight,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                  onPressed: () => mapController.move(location, 15),
                  icon: const Icon(Icons.my_location)
              ),
            ),
          ),
        )
      ],
    );
  }
}
