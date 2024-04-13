
import 'package:flutter/material.dart';

import '../../../../core/resources/strings_manager.dart';
import '../widgets/custom_error_widget.dart';

class ErrorView extends StatelessWidget {

  final void Function() onTap;
  final String errorText;
  final String buttonText;
  final double? height;

  const ErrorView({super.key,
    required this.onTap,
    this.errorText = 'Ha ocurrido un error',
    this.buttonText = AppStrings.reloadButton,
    this.height
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? MediaQuery.of(context).size.height*0.85,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomErrorWidget(text: errorText),
            const SizedBox(height: 50),
            FractionallySizedBox(
              widthFactor: 0.9,
              child: ElevatedButton(
                onPressed: onTap,
                child:Text(buttonText)),
            )
          ],
        ),
      ),
    );
  }
}
