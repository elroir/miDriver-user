import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/resources/strings_manager.dart';
import '../provider/pick_origin_provider.dart';

class MapWidget extends ConsumerWidget {


  const MapWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,ref) {
    final origin = ref.watch(pickOriginProvider);

    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
              center: const LatLng(-17.7853232, -63.1884931),
              zoom: 9.0,
              maxZoom: 18,
              minZoom: 6,
              onTap: (_, location) => ref.read(pickOriginProvider.notifier).pickOrigin(location)
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
                  if(origin!=null)
                  Marker(
                      point: origin,
                      height: 120,
                      width: 120,
                      builder: (context) =>
                          Icon(Icons.location_on, color: Theme
                              .of(context)
                              .primaryColor, size: 40)
                  )
                ]
            )
          ],
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.my_location)
          ),
        )
      ],
    );
  }
}
