import 'package:adhd_app/utiles/colors.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

String checkStringLang({
  required String ar,
  required String en,
  required BuildContext context,
}) {
  Locale currentLocale = Localizations.localeOf(context);
  String language = currentLocale.languageCode;
  if (language == "ar") {
    return ar;
    // the current locale is Arabic
  } else if (language == "en") {
    return en;
    // the current locale is English
  }
  return '';
}

bool checkLocalIsEn(BuildContext context) {
  Locale currentLocale = Localizations.localeOf(context);
  String language = currentLocale.languageCode;

  return language == 'en' ? true : false;
}

showCustomAwesomeDialog({
  required BuildContext context,
  void Function()? btnCancelOnPress,
  required String title,
  required String message,
  String? btnOkText,
  void Function()? btnOkOnPress,
  String? btnCancelText,
}) {
  AwesomeDialog(
    dialogBackgroundColor: Colors.white,
    context: context,
    dialogType: DialogType.warning,
    btnOkOnPress: btnOkOnPress,
    btnOkText: btnOkText,
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 1,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: AppColors.mainColor),
          ),
          Text(
            textAlign: TextAlign.center,
            message,
            maxLines: 3,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    ),
    btnCancelOnPress: btnCancelOnPress,
    btnCancelText: btnCancelText,
  ).show();
}
