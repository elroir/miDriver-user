import 'package:flutter/material.dart';

import '../../../../core/resources/values_manager.dart';
import '../../../../core/router/router.dart';
import '../../../../core/widgets/network_or_svg_picture.dart';
import '../../domain/entities/fare.dart';

class FareListTile extends StatelessWidget {

  final Fare fare;

  const FareListTile({Key? key, required this.fare}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(AppBorder.cardMaxBorderRadius)
      ),
      child: InkWell(
        onTap: () => context.go('${Routes.services}/${Routes.newService}/${fare.id}'),
        borderRadius: BorderRadius.circular(AppBorder.cardMaxBorderRadius),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
          child: Row(
            children: [
              Flexible(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(fare.title,style: Theme.of(context).textTheme.titleMedium),
                    Text(fare.description,style: Theme.of(context).textTheme.bodyMedium,maxLines: 4),
                  ],
                ),
              ),
              Flexible(
                flex: 2,
                child: NetworkOrSvgPicture(imageUrl: fare.imageUrl),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
