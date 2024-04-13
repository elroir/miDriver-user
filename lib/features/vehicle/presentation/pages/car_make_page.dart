import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/get_car_makes_provider.dart';
import '../provider/make_provider.dart';

class CarMakePage extends ConsumerWidget {
  const CarMakePage({super.key});

  @override
  Widget build(BuildContext context,ref) {
    final carMakes = ref.watch(getCarMakesProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: carMakes.when(
          data: (carMakes) => ListView.separated(
            itemCount: carMakes.length,
            shrinkWrap: true,
            separatorBuilder: (context,i) => const Divider(),
            itemBuilder: (context,i) => ListTile(
              onTap: () => ref.read(makeProvider.notifier).pickMake(carMakes[i]),
              title: Text(carMakes[i].makeName),
            ),
          ),
          error: (error,_) => const SizedBox(),
          loading: () => const Center(child: CircularProgressIndicator.adaptive())
      ),
    );
  }
}
