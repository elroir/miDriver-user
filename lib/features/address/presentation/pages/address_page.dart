import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/resources/strings_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/widgets/loading_button.dart';
import '../../../map/presentation/provider/current_location_provider.dart';
import '../../../map/presentation/provider/pick_location_provider.dart';

class AddressPage extends ConsumerWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context,ref) {
    final location = ref.watch(locationProvider);
    final locationSelection = ref.watch(pickLocationProvider);

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        leading: const CircleAvatar(
          backgroundColor: Colors.white,
            child: BackButton(color: Colors.black54)
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
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
                  initialCenter: location,
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
                              child: Icon(Icons.location_on,color: Colors.red,size: 40)
                          ),
                      ]
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const FractionallySizedBox(
                    widthFactor: 0.9,
                    child: Text('Esta será la dirección por defecto para el botón Ir a casa')
                  ),
                  const SizedBox(height: 10),
                  FractionallySizedBox(
                    widthFactor: 0.9,
                    child: TextFormField(
                        decoration: const InputDecoration(
                            labelText: AppStrings.addressField
                        )
                    ),
                  ),
                  const SizedBox(height: 40),
                  LoadingButton(onPressed: (){}, buttonText: AppStrings.save),
                ],
              )
            )
          ],
        ),
      )
    );
  }
}
