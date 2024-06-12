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
          color: Color(0xff363638),
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(AppBorder.cardMaxBorderRadius)),
        ),
        child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15)
            ),
            child: ClipRRect(
               borderRadius: BorderRadius.circular(25),
                child: Image.asset(AssetsManager.logo,height: 200,width: 200)
            )
        ),
      ),
    );
  }
}
