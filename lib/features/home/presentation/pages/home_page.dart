import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/http/entities/http_post_status.dart';
import '../../../user/presentation/provider/user_data_provider.dart';
import '../widgets/go_home_button.dart';
import '../widgets/home_bottom_bar.dart';

class HomePage extends ConsumerWidget {
  final Widget child;
  const HomePage({super.key, required this.child});

  @override
  Widget build(BuildContext context,ref) {
    final userStatus = ref.watch(userDataProvider);

    if(userStatus is HttpPostStatusLoading){
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    }
    return Scaffold(
      body: child,
      bottomNavigationBar: const HomeBottomBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const GoHomeButton()
    );
  }
}