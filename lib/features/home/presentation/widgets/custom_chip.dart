import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final Widget icon;
  final String text;
  const CustomChip({Key? key, required this.icon, required this.text,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(150),
          color: Theme.of(context).colorScheme.background
      ),
      child: Row(
        children: [
          icon,
          Text(text),
        ],
      ),
    );
  }
}
