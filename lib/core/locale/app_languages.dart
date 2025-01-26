import 'dart:ui';

import 'package:weather_app/core/locale/app_locale.dart';
import 'package:weather_app/core/utils/api/api_constants.dart';
import 'package:weather_app/core/utils/helpers/app_cache.dart';
import 'package:weather_app/core/utils/helpers/app_constants.dart';

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.english:
        return ApiConstants.en;
      case LanguageType.arabic:
        return ApiConstants.ar;
    }
  }
}

class LanguageChanging {
  Future<String> getAppLanguage() async {
    final String? language = AppCache.getData(key: AppConstants.chosenLang);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.arabic.getValue();
    }
  }

  Future<void> changeAppLanguage() async {
    final String currentLang = await getAppLanguage();

    if (currentLang == LanguageType.arabic.getValue()) {
      // set english
      AppCache.saveData(key: AppConstants.chosenLang, value: LanguageType.english.getValue());
    } else {
      // set arabic
      AppCache.saveData(key: AppConstants.chosenLang, value: LanguageType.arabic.getValue());
    }
  }

  Future<Locale> getLocale() async {
    final String currentLang = await getAppLanguage();

    if (currentLang == LanguageType.arabic.getValue()) {
      return AppLocale.arLocale;
    } else {
      return AppLocale.enLocale;
    }
  }
}

enum LanguageType { arabic, english }
