import 'package:flutter/material.dart';

import '../widgets/home_bottom_bar.dart';

class HomePage extends StatelessWidget {
  final Widget child;
  const HomePage({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: const HomeBottomBar(),
    );
  }
}