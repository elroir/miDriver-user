
import 'package:flutter/material.dart';

class FlagMarker extends StatelessWidget {

  final Color color;
  final String text;
  final TextStyle? textStyle;

  const FlagMarker({
    super.key,
    this.color = Colors.black,
    required this.text,
    this.textStyle
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 40,
          width: 80,
          decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(Radius.circular(5))
          ),
          child: Center(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(text,style: textStyle ?? Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 12),textAlign: TextAlign.center,)
            ),
          ),
        ),
        Container(
          height: 30,
          width: 5,
          color: color,
        ),
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(Radius.circular(5))
          ),
        )

      ],
    );
  }
}
