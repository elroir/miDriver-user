import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/resources/strings_manager.dart';
import '../../../home/presentation/pages/error_view.dart';
import '../provider/get_fares_provider.dart';
import '../widgets/fare_list_tile.dart';

class FarePage extends ConsumerWidget {
  const FarePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,ref) {
    final fares = ref.watch(getFaresProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(AppStrings.pickFare,style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),)
      ),
      body: fares.when(
          data: (fares) =>  ListView.builder(
            itemCount: fares.length,
            itemBuilder: (_,i) => FareListTile(fare: fares[i]),
          ),
          error: (error,_) => ErrorView(onTap: () => ref.invalidate(getFaresProvider)),
          loading: () => const Center(child: CircularProgressIndicator.adaptive())
      ),
    );
  }
}
