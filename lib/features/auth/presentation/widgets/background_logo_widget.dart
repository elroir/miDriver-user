import 'package:flutter/material.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/values_manager.dart';

class BackGroundLogoWidget extends StatelessWidget {
  const BackGroundLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: MediaQuery.of(context).size.height*0.4,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(AppBorder.cardMaxBorderRadius)),
        ),
        child: Container(
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(top: 20),
            child: Image.asset(AssetsManager.logoDark,height: 200,width: 200)
        ),
      ),
    );
  }
}
