// import 'dart:ui' as ui;

// ignore_for_file: depend_on_referenced_packages

import 'dart:ui' as ui;

import 'package:adhd_app/injection_container.dart'as di;
import 'package:shared_preferences/shared_preferences.dart';

import 'localizations_contents.dart';
// import 'injection_container.dart' as di;


class LanguageCacheHelper {
  Future<void> cacheLanguageCode(String langeCode) async {
    await di.sl<SharedPreferences>().setString("LOCAL", langeCode);
  }

  Future<String> getCachedLanguageCode() async {
    final cachedLanguageCode =di.sl<SharedPreferences>().getString("LOCAL");
    print('cach$cachedLanguageCode');
    if (cachedLanguageCode != null) {
      return cachedLanguageCode;
    } else {
      var deviceLang =
          localeResolutionCallback(ui.window.locale, supportedLocales)
              ?.languageCode;
      print('cach =>$deviceLang');

      return deviceLang.toString();
      // return 'en';
      // return ui.window.locale.languageCode;
    }
  }
}
