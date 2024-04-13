import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../../core/http/entities/http_post_status.dart';
import '../../../home/presentation/pages/error_view.dart';
import '../../../map/domain/entities/direction.dart';
import '../../../map/presentation/provider/direction_provider.dart';
import '../../../map/presentation/provider/pick_location_provider.dart';
import '../../../map/presentation/provider/polyline_provider.dart';
import '../../../map/presentation/widgets/location_selection_button.dart';
import '../../../map/presentation/widgets/map_widget.dart';
import '../provider/service_fare_provider.dart';
import '../provider/service_form_provider.dart';
import '../widgets/top_information_widget.dart';

class ServiceFormPage extends ConsumerWidget {
  final int fareId;
  const ServiceFormPage({super.key,required this.fareId});

  @override
  Widget build(BuildContext context,ref) {
    final serviceForm = ref.watch(serviceFormProvider);

    final serviceFare = ref.watch(serviceFareProvider(fareId));

    ref.listen(directionProvider, (previous, next) {
      if(next is HttpPostStatusSuccess){
        final direction = next.data as Direction;
        final location = ref.read(pickLocationProvider);
        ref.read(polylineProvider.notifier).drawPolyline(direction);
        ref.read(pickLocationProvider.notifier).confirm();
        ref.read(serviceFormProvider.notifier).fillDistanceAndPrice(direction.distanceInMeters,location.destination);

      }

    });


    if(serviceForm is HttpPostStatusLoading){
      return const Scaffold(body: Center(child: CircularProgressIndicator.adaptive()));
    }


    return Scaffold(

        body: serviceFare.when(
            data: (fare) {
              return const Stack(
                fit: StackFit.expand,
                children: [
                  MapWidget(),
                  Align(
                    alignment: Alignment.topCenter,
                    child: TopInformationWidget(),
                  ),
                  SafeArea(
                    bottom: true,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                          padding: EdgeInsets.only(bottom:20),
                          child: LocationSelectionButton()
                      ),
                    ),
                  )


                ],
              );
            } ,
            error: (error,_) => ErrorView(onTap: () => ref.invalidate(serviceFareProvider(fareId))),
            loading: () => const Center(child: CircularProgressIndicator.adaptive())
        )
    );
  }
}
