import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/http/entities/http_post_status.dart';
import '../../../../core/resources/strings_manager.dart';

import '../../domain/entities/direction.dart';
import '../provider/direction_provider.dart';
import '../provider/pick_location_provider.dart';
import '../provider/polyline_provider.dart';

class MapWidget extends ConsumerWidget {


  const MapWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,ref) {
    final locationSelection = ref.watch(pickLocationProvider);
    final polyline = ref.watch(polylineProvider);
    ref.listen(directionProvider, (previous, next) {
      if(next is HttpPostStatusSuccess){
        final direction = next.data as Direction;
        ref.read(polylineProvider.notifier).drawPolyline(direction);

      }

    });


    return Stack(
      children: [
        FlutterMap(
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
                      height: 120,
                      width: 120,
                      builder: (context) =>
                          Icon(Icons.location_on, color: Theme
                              .of(context)
                              .primaryColor, size: 40)
                  ),
                  if(locationSelection.destination!=null)
                    Marker(
                        point: locationSelection.destination!,
                        height: 120,
                        width: 120,
                        builder: (context) => const Icon(Icons.location_on, color: Colors.black, size: 40)
                    ),
                ]
            ),
            if(polyline!=null)
              PolylineLayer(
                polylines: [
                  polyline
                ],
              )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 80,right: 15),
          child: Align(
            alignment: Alignment.topRight,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.my_location)
              ),
            ),
          ),
        )
      ],
    );
  }
}
