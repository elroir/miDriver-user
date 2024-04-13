import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../home/presentation/widgets/custom_error_widget.dart';
import '../provider/get_offers_provider.dart';
import 'offer_list_tile.dart';

class OffersList extends ConsumerWidget {
  const OffersList({super.key});

  @override
  Widget build(BuildContext context,ref) {
    final offers = ref.watch(getOffersProvider);

    return offers.when(
        data: (offers) => SliverList(
          delegate: SliverChildBuilderDelegate(
                  (context,index) =>  OfferListTile(offer: offers[index]),
            childCount: offers.length,
          ),
        ),
        error: (error,_) => SliverToBoxAdapter(
          child: CustomErrorWidget(
            text: error.toString(),
          ),
        ),
        loading: () => const SliverToBoxAdapter(
          child: Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        )
    );
  }
}
