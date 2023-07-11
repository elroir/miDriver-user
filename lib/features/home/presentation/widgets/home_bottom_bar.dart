import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/resources/strings_manager.dart';
import '../../../user/presentation/provider/push_notification_provider.dart';
import '../provider/navigation_bar_provider.dart';

class HomeBottomBar extends ConsumerWidget {
  const HomeBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,ref) {

    final state = ref.watch(navigationBarProvider);
    ref.read(pushTokenProvider);


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