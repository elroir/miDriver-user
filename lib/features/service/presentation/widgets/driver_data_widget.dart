import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/http/http_options.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../home/presentation/pages/error_view.dart';
import '../../../offer/presentation/provider/get_offers_provider.dart';

class DriverDataWidget extends ConsumerWidget {
  const DriverDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,ref) {
    final offers = ref.watch(getOffersProvider);

    return SliverToBoxAdapter(
      child: offers.when(
          data: (offers) => Column(
            children: [
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(AppBorder.cardMaxBorderRadius),
                child: Hero(
                  tag: offers[0].user.id,
                  child: CachedNetworkImage(
                      imageUrl: offers[0].user.imageUrl,
                      httpHeaders: const {'Authorization' : HttpOptions.apiToken},
                      height: 250,
                      width: 250,
                      fit: BoxFit.cover
                  ),
                ),
              ),
              Text('${offers[0].user.name} ${offers[0].user.lastName}',style: Theme.of(context).textTheme.titleMedium),

            ],
          ),
          error: (error,_) => ErrorView(
            height: 400,
              onTap: () => ref.invalidate(getOffersProvider)
          ),
          loading: () => const Center(child: CircularProgressIndicator.adaptive()),
      ),
    );
  }
}
