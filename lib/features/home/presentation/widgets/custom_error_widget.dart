
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../core/resources/assets_manager.dart';

class CustomErrorWidget extends StatelessWidget {

  final String text;
  final double size;

  const CustomErrorWidget({super.key,this.text = 'Error',this.size = 128});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(AssetsManager.warning,
            height: size,
            width: size,
            colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn)
        ),
        const SizedBox(height: 15),
        Text(text,style: Theme.of(context).textTheme.headlineMedium,textAlign: TextAlign.center),
      ],
    );
  }
}
