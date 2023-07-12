import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../domain/entities/user_vehicle.dart';

class VehicleCard extends StatelessWidget {

  final UserVehicle vehicle;

  const VehicleCard({Key? key, required this.vehicle}) : super(key: key);

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
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(150),
                    color: Theme.of(context).colorScheme.background
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset( vehicle.transmissionType==AppStrings.manual
                          ? AssetsManager.mt
                          : AssetsManager.at,
                          colorFilter: ColorFilter.mode(Theme.of(context).textTheme.bodyLarge!.color!, BlendMode.srcIn),
                          height: 25
                      ),
                      Text(vehicle.transmissionType),
                    ],
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(label: Text(vehicle.plate)),
                IconButton(
                    onPressed: (){},
                    icon: const Icon(Iconsax.trash,color: Colors.red,size: 28)
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
