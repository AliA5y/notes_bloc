import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class Styles {
  static const headlineMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
}

class PrefsKeys {
  static const String languageKey = 'language';
  static const String themeKey = 'theme';
}

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}
