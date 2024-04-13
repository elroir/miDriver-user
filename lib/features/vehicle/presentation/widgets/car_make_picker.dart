import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/resources/strings_manager.dart';
import '../../../../core/router/router.dart';
import '../provider/make_provider.dart';

class CarMakePicker extends ConsumerWidget {
  const CarMakePicker({super.key});

  @override
  Widget build(BuildContext context,ref) {

    final make = ref.watch(makeProvider);
    return TextFormField(
      readOnly: true,
      controller: TextEditingController(text: make?.makeName ?? ''),
      onTap: () => context.pushNamed(Routes.make),
      decoration: const InputDecoration(
          hintText: AppStrings.carMake,
          suffixIcon: Icon(Icons.keyboard_arrow_down)
      ),

    );
  }
}
