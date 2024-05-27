part of 'themes.dart';

class ButtonThemeStyle{

  static ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 15),
      textStyle: const TextStyle(fontWeight: FontWeight.w500),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppBorder.buttonBorderRadius)
      )
    ),
  );

  static OutlinedButtonThemeData outlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 13),
        foregroundColor: Colors.black,
        textStyle: const TextStyle(fontWeight: FontWeight.w500),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppBorder.buttonBorderRadius)
        )
    ),
  );

  static OutlinedButtonThemeData outlinedButtonDarkTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 13),
        foregroundColor: Colors.white60,
        textStyle: const TextStyle(fontWeight: FontWeight.w500),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppBorder.buttonBorderRadius)
        )
    ),
  );

}