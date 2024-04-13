import 'package:flutter/material.dart';

class ButtonLoadingAnimation extends StatelessWidget {

  final Color color;

  const ButtonLoadingAnimation({super.key, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: Alignment.centerRight,
        child: SizedBox(
            height: 16,
            width: 16,
            child: CircularProgressIndicator(color: color,strokeWidth: 2,)
        ),
      ),
    );
  }
}
