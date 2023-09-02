import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/http/http_options.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../home/presentation/widgets/custom_chip.dart';
import '../../domain/entities/offer.dart';
import '../provider/accept_offer_provider.dart';

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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(child: Text('${offer.user.name} ${offer.user.lastName}',style: Theme.of(context).textTheme.titleSmall,maxLines: 2,)),
                          if(offer.distance!=null)
                            CustomChip(
                                icon: const Icon(Iconsax.location,size: 18,),
                                text: ' ${offer.distance!.toStringAsFixed(2)} km'
                            ),
                        ],
                      ),
                      const Spacer(),
                      Consumer(
                        builder: (context,ref,child) => FractionallySizedBox(
                          widthFactor: 1,
                          child: ElevatedButton(
                              onPressed: () => ref.read(acceptOfferProvider.notifier).acceptOffer(offer.id),
                              child: const Text(AppStrings.accept)
                          ),
                        )
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
