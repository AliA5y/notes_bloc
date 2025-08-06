import 'package:flutter/material.dart';

mixin AppTheme implements ThemeData {
  static const darkSurface = Color.fromARGB(255, 10, 19, 34);
  static const darkBackground = Color.fromRGBO(29, 38, 53, 1);
  static const lightBackground = Colors.white;
  static const lightSurface = Color.fromARGB(255, 245, 247, 255);
  static const lightGrey = Color.fromARGB(255, 215, 218, 218);
  static const extraLightGrey = Color.fromARGB(255, 236, 236, 240);
  static const blueGrey = Color(0xFF6699CC);
  static const dustyBlueGrey = Color(0xFF748A9E);
  static const lightBlueGrey = Color(0xFF9DBCD4);
  static const payneyGrey = Color(0xFF536878);
  static const blackIcon = Colors.black87;
  // static get darkerOrLighter = ? : Color(0xFF536878);

  static const String tmiseNewRomanFontFamily = 'TimesNewRoman';
  static const String iBMPlexSansArabicFontFamily = 'IBMPlexSansArabic';
  static ThemeData lightTheme() {
    return ThemeData(
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      }),
      fontFamily: iBMPlexSansArabicFontFamily,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        surface: lightSurface,
        onSurface: darkSurface,
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      }),
      fontFamily: iBMPlexSansArabicFontFamily,
      colorScheme: ColorScheme.fromSwatch(brightness: Brightness.dark).copyWith(
        surface: darkSurface,
        onSurface: lightSurface,
      ),
    );
  }

  static Color getBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? AppTheme.lightBackground
        : AppTheme.darkBackground;
  }

  static Border edgeBorder(
      {Color color = AppTheme.blueGrey, double width = 0.8}) {
    return Border.all(
      color: color,
      width: width,
    );
  }
}
