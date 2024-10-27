import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class Styles {
  static const headlineLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );
  static const headlineMedium = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w500,
  );
  static const headlineSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
}

class Versions {
//* Important: change this number with each app release
  static const currentAppVer = 1;
//* Important: change this number when you change how user id is fetched
  static const currentUserIdVer = 1;
//* Important: change this number when you update Db version
  static const currentDbver = 1;
}

class PrefsKeys {
  static const String languageKey = 'language';
  static const String themeKey = 'theme';
  static const String idKey = 'deviceId:${Versions.currentUserIdVer}';
}

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}

const avatarCodes = [
  8,
  14,
  16,
  15,
  26,
  24,
  21,
  30,
  42,
  37,
  58,
  48,
  59,
  60,
  66,
  70,
  68,
  75,
  81,
  142,
  95,
  137,
  106,
  143,
  108,
  169,
  145,
  196,
  148,
  207,
  201,
  222,
  200,
  228,
  203,
  240,
  202,
  260,
  219,
  296,
  220,
  330,
  208,
  354,
  226,
  356,
  241,
  358,
  246,
  361,
  247,
  368,
  329,
  375,
  337,
  359,
  347,
  409,
  342,
  410,
  351,
  412,
  362,
  413,
  365,
  426,
  373,
  444,
  384,
  451,
  405,
  454,
  443,
  458,
  448,
  456,
  506,
  487,
  530,
  494,
  539,
  497,
  557,
  507,
  600,
  512,
  612,
  514,
  901,
  511,
  518,
  425,
  546,
  555,
  602,
  615,
  933,
  932,
  896
];
