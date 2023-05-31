import 'package:adhd_app/localization/app_localizations.dart';
import 'package:adhd_app/localization/local/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../injection_container.dart' as di;
import '../colors.dart';

class SwitchLanguage extends StatelessWidget {
  const SwitchLanguage({super.key});

  // bool isLam
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, ChangeLocaleState>(
      buildWhen: (previous, current) => previous.locale != current.locale,
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              "Language".tr(context),
              style: TextStyle(
                color: AppColors.mainColor,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            DropdownButton(
                // underline: ,

                elevation: 0,

                // disabledHint: true,
                style: TextStyle(
                  color: AppColors.mainColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                // style: TextStyle(color: Colors.white),
                autofocus: false,
                value: state.locale.languageCode,
                focusColor: Colors.white,
                // dropdownColor: Color.fromARGB(255, 126, 88, 88),
                items: ['ar', 'en']
                    .map((e) => DropdownMenuItem<String>(
                          enabled: true,
                          alignment: AlignmentDirectional.center,
                          value: e,
                          child: Text(e.toString()),
                        ))
                    .toList(),
                onChanged: (newValue) {
                  if (newValue != null) {
                    print(newValue);
                    BlocProvider.of<LocaleCubit>(context)
                        .changeLanguage(newValue.toString(), isFirstTime: true);
                  }
                }),
          ],
        );
      },
    );
  }
}
