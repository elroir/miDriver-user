import 'package:flutter/material.dart';

class ProfileField extends StatelessWidget {
  
  final String title;
  final String content;
  final Widget icon;
  
  const ProfileField({super.key, required this.title, required this.content, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text(title),
      subtitle: Text(content),
    );
  }
}
