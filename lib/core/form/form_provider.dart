import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormProvider extends StateNotifier<GlobalKey<FormState>>{
  FormProvider(super.state);
}
final formProvider = StateNotifierProvider.autoDispose<FormProvider,GlobalKey<FormState>>(
        (ref) => FormProvider(GlobalKey<FormState>())
);