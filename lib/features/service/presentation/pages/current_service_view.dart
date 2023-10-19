import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/http/entities/http_post_status.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../offer/presentation/provider/accept_offer_provider.dart';
import '../../../offer/presentation/provider/get_offers_provider.dart';
import '../../../offer/presentation/widgets/offers_list.dart';
import '../../domain/entities/service.dart';
import '../provider/cancel_service_provider.dart';
import '../provider/get_current_service_provider.dart';
import '../widgets/driver_data_widget.dart';
import '../widgets/my_service_widget.dart';
class CurrentServiceView extends ConsumerStatefulWidget {
  const CurrentServiceView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CurrentViewState();
}

class _CurrentViewState  extends ConsumerState<CurrentServiceView> with WidgetsBindingObserver{
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state==AppLifecycleState.resumed){
      ref.invalidate(getCurrentServiceProvider);
      ref.invalidate(getOffersProvider);
    }

  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final service = ref.read(getCurrentServiceProvider).value!;

    ref.listen(cancelServiceProvider, (previous, next) {
      if(next is HttpPostStatusSuccess){
        ref.invalidate(getCurrentServiceProvider);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(AppStrings.serviceCancelled),
          )
        );
      }
    });
    ref.listen(acceptOfferProvider, (previous, next) {
      if(next is HttpPostStatusSuccess){
        ref.invalidate(getCurrentServiceProvider);
        ref.invalidate(getOffersProvider);

        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(AppStrings.serviceAccepted),
            )
        );
      }
    });
    return CustomScrollView(
      slivers: [
        const MyServiceWidget(),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.serviceFormPadding,vertical: 5),
            child: Text((service.status==ServiceStatus.published) ? AppStrings.driversOffers : AppStrings.driverInCharge,style: Theme.of(context).textTheme.titleMedium),
          ),
        ),
        if(service.status==ServiceStatus.published)
          const OffersList(),
        if(service.status==ServiceStatus.accepted||service.status==ServiceStatus.inProgress)
          const DriverDataWidget()

      ],
    );
  }
}
