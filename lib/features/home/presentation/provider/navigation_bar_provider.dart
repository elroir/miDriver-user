

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/router/router.dart';


final navigationBarProvider = StateNotifierProvider<NavigationBarNotifier,int>(
        (ref) => NavigationBarNotifier(ref.read(router))
);


class NavigationBarNotifier extends StateNotifier<int> {

  final GoRouter _router;

  NavigationBarNotifier(this._router) : super(0);

  void onChangeTab(int index) {
    state = index;
    if(index==0){
      _router.go(Routes.profile);
    }
    if(index==1){
      _router.go(Routes.services);
    }


  }

}