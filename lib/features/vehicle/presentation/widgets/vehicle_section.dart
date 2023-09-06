import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/http/entities/http_post_status.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/router/router.dart';
import '../provider/delete_vehicle_provider.dart';
import '../provider/get_vehicles_provider.dart';
import '../provider/vehicle_provider.dart';
import 'add_vehicle.dart';
import 'delete_vehicle_dialog.dart';
import 'vehicle_card.dart';

class VehicleSection extends ConsumerWidget {
  const VehicleSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,ref) {
    final vehicles = ref.watch(getVehiclesProvider);

    ref.listen(vehicleProvider, (previous, next) {
      if(next is HttpPostStatusSuccess){
        ref.invalidate(getVehiclesProvider);
      }
    });

    ref.listen(deleteVehicleProvider, (previous, next) {

      if(next is HttpPostStatusInProgress){
        showDialog(
            context: context,
            builder: (_) => const DeleteVehicleDialog()
        );
      }

      if(next is HttpPostStatusLoading){
        context.pop();
      }

      if(next is HttpPostStatusSuccess){
        ref.invalidate(getVehiclesProvider);
      }
    });

    return vehicles.when(
        data: (cars){
          if(cars.isEmpty){
            return const SliverToBoxAdapter(child: AddVehicleWidget());
          }

          return SliverList(
              delegate: SliverChildBuilderDelegate(
                      (_,i) => (i>=cars.length)
                          ? FractionallySizedBox(
                        widthFactor: 0.9,
                          child: ElevatedButton(
                              onPressed: () => context.push(Routes.vehicle),
                              child: const Text(AppStrings.carRegister)
                          )
                      )
                          : VehicleCard(vehicle: cars[i]),
                  childCount: cars.length+1
              )
          );

        },
        error: (error,stackTrace) => const SliverToBoxAdapter(child: SizedBox()),
        loading: () => const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator.adaptive()))
    );
  }
}
