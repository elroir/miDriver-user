import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/resources/strings_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/router/router.dart';

class LocationMapPage extends StatelessWidget {

  final LatLng location;

  const LocationMapPage({Key? key, required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
                center: location,
                zoom: 15.0,
                maxZoom: 18,
                minZoom: 6,
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
                    Marker(
                        point: location,
                        height: 120,
                        width: 120,
                        builder: (context) =>
                            const Icon(Icons.location_on, color: Colors.black, size: 40)
                    ),
                  ]
              ),
              CurrentLocationLayer(),

            ],
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.horizontalPadding,vertical: AppPadding.topPadding),
              child: Align(
                alignment: Alignment.topLeft,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: BackButton(
                    onPressed: () => context.go(Routes.services),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
