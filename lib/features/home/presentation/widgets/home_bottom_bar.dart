import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/resources/strings_manager.dart';
import '../../../../core/router/router.dart';
import '../../../map/presentation/provider/location_permission_provider.dart';
import '../../../offer/presentation/provider/get_offers_provider.dart';
import '../../../service/presentation/provider/get_current_service_provider.dart';
import '../../../user/presentation/provider/push_notification_provider.dart';
import '../provider/navigation_bar_provider.dart';
import '../provider/notification_data_provider.dart';

class HomeBottomBar extends ConsumerWidget {
  const HomeBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,ref) {

    final state = ref.watch(navigationBarProvider);
    ref.read(pushTokenProvider);

    ref.read(locationPermissionProvider);

    ref.listen(notificationDataProvider, (previous, next) {
      if(next!=null){
        print(next);
        if(next['action']=='refresh_offer'){
          ref.invalidate(getOffersProvider);
        }

        if(next['action']=='refresh_service'){
          print(next['status']);

          ref.invalidate(getCurrentServiceProvider);
          if(next['status']=='finished'){
            context.goNamed(Routes.finishedService);
          }
        }

      }
    });
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: NavigationBar(
        selectedIndex: state,
        height: 60,
        onDestinationSelected: ref.read(navigationBarProvider.notifier).onChangeTab,
        destinations: const [
          NavigationDestination(
              icon: Icon(Iconsax.personalcard),
              label: AppStrings.profile
          ),
          NavigationDestination(
              icon: Icon(Iconsax.car),
              label: AppStrings.services
          ),
        ],
      )
    );
  }
}