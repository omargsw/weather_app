import 'package:flutter/material.dart';

import '../utils/helpers/app_constants.dart';

class AppLocale {
  const AppLocale._();

  static const String translationsPath = 'assets/translations';

  static const arLocale = Locale(AppConstants.arabicCode, AppConstants.arabicCountry);
  static const enLocale = Locale(AppConstants.englishCode, AppConstants.englishCountry);

  static const List<Locale> supportLocales = [arLocale, enLocale];
}
