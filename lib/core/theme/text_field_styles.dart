import 'package:flutter/material.dart';

import '../resources/values_manager.dart';

class TextFieldStyles{

  static const InputDecorationTheme textTheme = InputDecorationTheme(
    filled: true,
    border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppBorder.textFieldBorderRadius)),
        borderSide: BorderSide.none
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
    hintStyle: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w300,
    ),
  );
}