

import 'package:flutter/material.dart';

import '../resources/values_manager.dart';
import 'text_field_styles.dart';
import 'text_theme.dart';

part 'button_theme.dart';

class Themes {

  static final ThemeData lightTheme = ThemeData(
      primaryColor: Colors.white,
      fontFamily: 'Poppins',
      useMaterial3: true,
      textTheme: TextThemeStyle.textTheme,
      visualDensity: VisualDensity.standard,
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppBorder.cardBorderRadius)),
        margin: const EdgeInsets.symmetric(horizontal: 15),
      ),
      elevatedButtonTheme: ButtonThemeStyle.elevatedButtonTheme,
      outlinedButtonTheme: ButtonThemeStyle.outlinedButtonTheme,
      navigationBarTheme: const NavigationBarThemeData(
        indicatorColor: Colors.white60,
        backgroundColor: Colors.white60,
        iconTheme: MaterialStatePropertyAll(
            IconThemeData(
              color:  Colors.black,
            )
        ),
        labelTextStyle: MaterialStatePropertyAll(
            TextStyle(
                color: Colors.black
            )
        ),
      ),
      appBarTheme: const AppBarTheme(
          color: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(color: Colors.black87,fontSize: 18,fontWeight: FontWeight.w500,fontFamily: 'Poppins'),
          iconTheme: IconThemeData(
              color: Colors.white
          )
      ),
      inputDecorationTheme: TextFieldStyles.textTheme
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: Colors.black,
      fontFamily: 'Poppins',
      useMaterial3: true,
      brightness: Brightness.dark,
      textTheme: TextThemeStyle.textTheme,
      elevatedButtonTheme: ButtonThemeStyle.elevatedButtonTheme,
      outlinedButtonTheme: ButtonThemeStyle.outlinedButtonDarkTheme,
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppBorder.cardBorderRadius)),
        margin: const EdgeInsets.symmetric(horizontal: 15),
      ),
      appBarTheme: const AppBarTheme(
        color: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500,fontFamily: 'Poppins'),
      ),
      inputDecorationTheme: TextFieldStyles.textTheme

  );
}