import 'package:flutter/material.dart';

import '../../../address/presentation/widgets/default_address_service_dialog.dart';
import '../widgets/home_bottom_bar.dart';

class HomePage extends StatelessWidget {
  final Widget child;
  const HomePage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: const HomeBottomBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
            context: context,
            builder: (_) => const DefaultAddressServiceDialog()
        ),
        backgroundColor: Colors.green,
        child: const Icon(Icons.home_filled),
      )
    );
  }
}