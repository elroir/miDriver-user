import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/http/http_options.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../domain/entities/offer.dart';

class OfferListTile extends StatelessWidget {
  final Offer offer;
  const OfferListTile({Key? key,required this.offer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Card(
        child: IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.horizontalPadding,vertical: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppBorder.cardMaxBorderRadius),
                  child: CachedNetworkImage(
                    imageUrl: offer.user.imageUrl,
                    httpHeaders: const {'Authorization' : HttpOptions.apiToken},
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10,bottom: 10,right: AppPadding.horizontalPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text('${offer.user.name} ${offer.user.lastName}',style: Theme.of(context).textTheme.titleSmall,),
                      Text('${AppStrings.offeredPrice} Bs. ${offer.price}',style: Theme.of(context).textTheme.bodyMedium,),
                      const Spacer(),
                      FractionallySizedBox(
                        widthFactor: 1  ,
                        child: ElevatedButton(
                            onPressed: (){},
                            child: const Text(AppStrings.accept)
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
