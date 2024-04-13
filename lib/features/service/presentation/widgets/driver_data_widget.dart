import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/http/http_options.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../home/presentation/pages/error_view.dart';
import '../../../offer/presentation/provider/get_offers_provider.dart';
import '../../domain/entities/service.dart';
import '../provider/get_current_service_provider.dart';

class DriverDataWidget extends ConsumerWidget {
  const DriverDataWidget({super.key});

  @override
  Widget build(BuildContext context,ref) {
    final offers = ref.watch(getOffersProvider);
    final service = ref.read(getCurrentServiceProvider).value!;

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
                      httpHeaders: HttpOptions.imageHeaders,
                      height: 250,
                      width: 250,
                      fit: BoxFit.cover
                  ),
                ),
              ),
              Text('${offers[0].user.name} ${offers[0].user.lastName}',style: Theme.of(context).textTheme.titleMedium),
              if(service.status == ServiceStatus.inProgress)
                Text(AppStrings.driverOnTheWay,style: Theme.of(context).textTheme.bodyLarge)

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
