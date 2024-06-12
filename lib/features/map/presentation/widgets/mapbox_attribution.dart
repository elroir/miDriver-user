import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../home/presentation/provider/launch_url_provider.dart';

class MapBoxAttribution extends ConsumerWidget {
  const MapBoxAttribution({super.key});

  @override
  Widget build(BuildContext context,ref) {
    return RichAttributionWidget(
        alignment: AttributionAlignment.bottomRight,
        showFlutterMapAttribution: false,
        attributions: [
          LogoSourceAttribution(
            SvgPicture.asset(AssetsManager.mapboxIconBlack,alignment: Alignment.centerLeft),
            height: 50,
          ),
          TextSourceAttribution('MAPBOX',
              onTap: () => ref.read(openUrlProvider.notifier).openUrl('https://www.mapbox.com/about/maps'),
          ),
          TextSourceAttribution('OpenStreetMap',
            onTap: () => ref.read(openUrlProvider.notifier).openUrl('http://www.openstreetmap.org/copyright'),
          ),
          TextSourceAttribution(AppStrings.improveThisMap,
            onTap: () => ref.read(openUrlProvider.notifier).openUrl('https://www.mapbox.com/map-feedback'),
          ),
          TextSourceAttribution('flutter_map',
            onTap: () => ref.read(openUrlProvider.notifier).openUrl('https://pub.dev/packages/flutter_map'),
          ),
        ]
    );
  }
}
