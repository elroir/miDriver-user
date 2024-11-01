import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../home/presentation/widgets/custom_chip.dart';
import '../../domain/entities/user_vehicle.dart';
import '../provider/delete_vehicle_provider.dart';

class VehicleCard extends StatelessWidget {

  final UserVehicle vehicle;

  const VehicleCard({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: Text('${vehicle.make.makeName} ${vehicle.model} ${vehicle.year}',
                        style: Theme.of(context).textTheme.bodyLarge,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis
                    )
                ),
                CustomChip(
                  icon: SvgPicture.asset( vehicle.transmissionType==AppStrings.manual
                      ? AssetsManager.mt
                      : AssetsManager.at,
                      colorFilter: ColorFilter.mode(Theme.of(context).textTheme.bodyLarge!.color!, BlendMode.srcIn),
                      height: 25
                  ),
                   text: vehicle.transmissionType
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(label: Text(vehicle.plate)),
                Consumer(
                    builder: (context,ref,child) => IconButton(
                        onPressed: () => ref.read(deleteVehicleProvider.notifier).openDialog(vehicle.id),
                        icon: const Icon(Iconsax.trash,color: Colors.red,size: 28)
                    )
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
