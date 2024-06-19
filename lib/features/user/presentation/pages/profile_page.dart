import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/http/entities/http_post_status.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/router/router.dart';
import '../../../address/presentation/provider/get_addresses_provider.dart';

import '../../../../core/resources/strings_manager.dart';
import '../../../auth/presentation/widgets/background_logo_widget.dart';
import '../../../auth/presentation/widgets/logout_button.dart';
import '../../../home/presentation/pages/error_view.dart';
import '../provider/user_data_provider.dart';
import '../widgets/delete_user_button.dart';
import '../widgets/profile_field.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context,ref) {
    final userStatus = ref.watch(userDataProvider);

    if(userStatus is HttpPostStatusLoading){
      return const Center(child: CircularProgressIndicator.adaptive());
    }

    if(userStatus is HttpPostStatusSuccess){

      ref.listen(getAddressesProvider, (previous, next) {
        if(next is HttpPostStatusSuccess && previous is HttpPostStatusNone){
          if(next.data!.isEmpty){
            context.push(Routes.addressForm);
          }else{
            context.push(Routes.address);
          }
        }

      });

      return CustomScrollView(

          slivers: [
            SliverAppBar(
              expandedHeight:MediaQuery.sizeOf(context).height*0.35,
                flexibleSpace: const FlexibleSpaceBar(
                  background: BackGroundLogoWidget(),
                  collapseMode: CollapseMode.pin,
                ),

            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                    [
                      ProfileField(
                        icon: const Icon(Iconsax.user),
                        title: AppStrings.nameField,
                        content: '${userStatus.data!.name} ${userStatus.data!.lastName}',
                      ),
                      ProfileField(
                        icon: const Icon(CupertinoIcons.mail),
                        title: AppStrings.emailField,
                        content: userStatus.data!.email,
                      ),
                      ProfileField(
                        icon: const Icon(Iconsax.mobile),
                        title: AppStrings.phoneField,
                        content: userStatus.data!.phoneNumber.toString(),
                      ),

                      // ProfileField(
                      //   icon: const Icon(Iconsax.location),
                      //   title: AppStrings.addressField,
                      //   content: userStatus.data!.address,
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 5),
                      //   child: Text(AppStrings.vehicles,style: Theme.of(context).textTheme.titleMedium),
                      // ),
                      // const SizedBox(height: 10)
                    ]
                ),
              ),
            ),
            // const VehicleSection(),
            const SliverToBoxAdapter(child: SizedBox(height: 40)),
            const SliverToBoxAdapter(
              child: Center(child: LogoutButton()),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 30,bottom: 10),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Iconsax.warning_2,color: Colors.red,),
                      const SizedBox(width: 10,),
                      Text(AppStrings.dangerZone,style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.red),),
                    ],
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: DeleteUserButton(),
                )
            ),
          ]
      );
    }
    return ErrorView(
        errorText: userStatus.message,
        buttonText: AppStrings.goBack,
        onTap: () => context.go(Routes.login)
    );
  }
}

