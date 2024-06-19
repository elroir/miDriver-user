import 'package:flutter/material.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/router/router.dart';
import '../widgets/address_list.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.close,color: (Theme.of(context).brightness==Brightness.light) ? Colors.black54 : null)
      )
      ),
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SafeArea(
              child: Column(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(AppBorder.logoBorderRadius),
                      child: Image.asset(AssetsManager.logo,height: 150,width: 150)
                  ),
                  Text('miDriver',style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold,fontSize: 32),)
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(bottom: AppPadding.topPadding),
              child: Text(AppStrings.whereYouGo,style: Theme.of(context).textTheme.titleLarge,textAlign: TextAlign.center,),
            ),
          ),
          const AddressList()
        ],

      ),

    );
  }
}
