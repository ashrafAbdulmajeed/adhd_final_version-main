import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale? locale;
//we will use this class in our custom delegate
  AppLocalizations({this.locale});
  //we will provide an object base on the context
  static AppLocalizations? of(BuildContext context) {
    //this lines tells the frameWork that this class is for the Localization
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();
  late Map<String, String> _localizedStrings;
  Future loadJsonLanguages() async {
    //this function will get the keys of the texts from json files
    String jsonString =
        await rootBundle.loadString("assets/lang/${locale!.languageCode}.json");
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    _localizedStrings = jsonMap.map(
      (key, value) => MapEntry(
        key,
        value.toString(),
      ),
    );
  }

//this function takes the key and return the translated text AppLocalizations in line 16
  String translate(String key) => _localizedStrings[key] ?? "";
}

//here we will do the actual delegate and take object of it in
class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();
  //make sure if the app supporting the lang or not if yes it complete else stopped
  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

//this func get the device
  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations appLocalizations = AppLocalizations(locale: locale);
    await appLocalizations.loadJsonLanguages();
    return appLocalizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}

extension TranslateX on String {
  String tr(BuildContext context) =>
      AppLocalizations.of(context)!.translate(this);
}
