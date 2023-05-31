import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_localizations.dart';

const Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates = [
  AppLocalizations.delegate,
  GlobalMaterialLocalizations
      .delegate, //Responsible for translating some texts in Material
  GlobalWidgetsLocalizations
      .delegate, //Responsible for the direction of the elements
  GlobalCupertinoLocalizations
      .delegate, // Responsible for translating some texts in Cupertino
];
Locale? Function(Locale?, Iterable<Locale>) localeResolutionCallback =
    (deviceLocale, supportedLocales) {
  ///TODO
  // final cachedLanguageCode = sl<SharedPreferences>().getString("LOCAL");
  // if (cachedLanguageCode != null) return Locale(cachedLanguageCode);
  for (var locale in supportedLocales) {
    if (deviceLocale != null &&
        deviceLocale.languageCode == locale.languageCode) {
      // print(deviceLocale.languageCode);
      return deviceLocale;
    }
  }
  return supportedLocales.first;
};
// (deviceLocale, supportedLocales) {
// for (var locale in supportedLocales) {
// if (deviceLocale != null &&
// deviceLocale.languageCode == locale.languageCode) {
// return deviceLocale;
// }
// }
//
// return supportedLocales.first;
// },
const Iterable<Locale> supportedLocales = [
  //The Languages that the app supports
  Locale('en'),
  Locale('ar'),
];
