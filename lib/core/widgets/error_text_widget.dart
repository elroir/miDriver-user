import 'package:flutter/material.dart';

class ErrorTextWidget extends StatelessWidget {

  final EdgeInsetsGeometry padding;
  final String errorText;

  const ErrorTextWidget({super.key, this.padding = const EdgeInsets.symmetric(vertical: 15), required this.errorText});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: padding,
      child: Text(errorText,style: const TextStyle(color: Colors.red) ),
    );
  }
}
