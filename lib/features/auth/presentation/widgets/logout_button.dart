import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/resources/strings_manager.dart';
import '../../../../core/widgets/button_loading_animation.dart';
import '../provider/logout_provider.dart';

class LogoutButton extends ConsumerWidget {
  final String text;
  const LogoutButton({super.key,this.text = AppStrings.logout});

  @override
  Widget build(BuildContext context,ref) {
    final logout = ref.watch(logoutProvider);
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: OutlinedButton(
        onPressed: logout != LogoutStatus.loading ? () => ref.read(logoutProvider.notifier).call() : null,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(text),
            if(logout == LogoutStatus.loading)
              const ButtonLoadingAnimation()
          ],
        ),
      ),
    );
  }
}
