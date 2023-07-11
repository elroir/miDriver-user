import 'package:flutter/material.dart';

class ProfileField extends StatelessWidget {
  
  final String title;
  final String content;
  final Widget icon;
  
  const ProfileField({Key? key, required this.title, required this.content, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text(title),
      subtitle: Text(content),
    );
  }
}
