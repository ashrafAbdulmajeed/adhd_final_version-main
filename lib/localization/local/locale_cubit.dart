import 'package:adhd_app/localization/language_cache_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:yemen_coffee/core/localization/language_cache_helptainer.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<ChangeLocaleState> {
  LocaleCubit() : super(ChangeLocaleState(locale: Locale('en')));

  Future<void> getSavedLanguage() async {
    // emit(const ChangeLocaleLoadingState());
    final String cachedLanguageCode =
        await LanguageCacheHelper().getCachedLanguageCode();
    emit(state.copyWith(locale: Locale(cachedLanguageCode)));
    // emit(ChangeLocaleState(locale: Locale(cachedLanguageCode)));
    if (kDebugMode) {
      print("cubit $cachedLanguageCode");
    }
  }

  Future<void> changeLanguage(String languageCode,
      {required bool isFirstTime}) async {
    // emit(const ChangeLocaleLoadingState());
    if (kDebugMode) {
      print('calle');
    }
    await LanguageCacheHelper().cacheLanguageCode(languageCode);
    // emit(ChangeLocaleState(locale: Locale(languageCode)));
    emit(state.copyWith(locale: Locale(languageCode)));

    // isFirstTime ? di.sl<SharedPreferences>().setString("step", "one") : null;
    // emit(ChangeLocaleToArState(locale: Locale(languageCode)));
  }
}
