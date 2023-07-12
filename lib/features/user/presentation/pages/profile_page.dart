import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import '../../../auth/presentation/widgets/background_logo_widget.dart';

import '../../../../core/resources/strings_manager.dart';
import '../../../auth/presentation/widgets/logout_button.dart';
import '../../../vehicle/presentation/widgets/vehicle_section.dart';
import '../provider/user_data_provider.dart';
import '../widgets/profile_field.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,ref) {
    final user = ref.watch(userDataProvider);
    return Scaffold(
      body: user != null ? CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: BackGroundLogoWidget()
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  ProfileField(
                    icon: const Icon(CupertinoIcons.mail),
                    title: AppStrings.emailField,
                    content: user.email,
                  ),
                  ProfileField(
                    icon: const Icon(Iconsax.mobile),
                    title: AppStrings.phoneField,
                    content: user.phoneNumber.toString(),
                  ),
                  ProfileField(
                    icon: const Icon(Iconsax.location),
                    title: AppStrings.addressField,
                    content: user.address,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text('Vehículos',style: Theme.of(context).textTheme.titleMedium),
                  ),
                  const SizedBox(height: 10)
                ]
              ),
            ),
          ),
          const VehicleSection(),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
          const SliverToBoxAdapter(
            child: Center(child: LogoutButton()),
          )
        ]
      ) : const Center(child: CircularProgressIndicator.adaptive()),
    );
  }
}

