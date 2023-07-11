
import 'package:flutter/material.dart';

import 'button_loading_animation.dart';

class LoadingButton extends StatelessWidget {

  final bool isLoading;
  final void Function() onPressed;
  final double widthFactor;
  final String buttonText;

  const LoadingButton({
    super.key,
    this.isLoading = false,
    required this.onPressed,
    this.widthFactor = 0.9,
    required this.buttonText
  });


  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: widthFactor,
      child: ElevatedButton(
          onPressed: !isLoading ? onPressed : null,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(buttonText),
              if (isLoading)
                const ButtonLoadingAnimation(color: Colors.white)

            ],
          )
      ),
    );
  }
}