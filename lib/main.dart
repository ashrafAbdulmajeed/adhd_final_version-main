// ignore_for_file: unused_import, depend_on_referenced_packages

import 'dart:io';

import 'package:adhd_app/data/doctors.dart';
import 'package:adhd_app/localization/local/locale_cubit.dart';
import 'package:adhd_app/models/article.dart';
import 'package:adhd_app/provider/bloc_observer.dart';
import 'package:adhd_app/screens/auth/login_screen.dart';
import 'package:adhd_app/screens/child_info/child_info_screen.dart';
import 'package:adhd_app/screens/fun_activities/fun_activity_screen.dart';
import 'package:adhd_app/screens/home/home_screen.dart';
import 'package:adhd_app/screens/onboarding/on_boarding_screen.dart';
import 'package:adhd_app/screens/questionaire/questions_screen.dart';
import 'package:adhd_app/screens/settings/settings_screen.dart';
import 'package:adhd_app/screens/specialists/specialists_screen.dart';
import 'package:adhd_app/screens/splash/splash_page.dart';
import 'package:adhd_app/utiles/app_constants.dart';
import 'package:adhd_app/utiles/network/local/cache_helper.dart';
import 'package:adhd_app/utiles/themes.dart';
import 'package:adhd_app/utiles/widgets/intro_questionnaire_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'injection_container.dart' as di;
import 'localization/localizations_contents.dart';
import 'provider/general_app_cubit/app_general_cubit.dart';

//internet + API
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //initilize bloc

  await di.init();

  Bloc.observer = MyBlocObserver();

  //access to every thing on internet + API (reciving information outside from app)
  HttpOverrides.global = new MyHttpOverrides();

//initilize cache helper to store data on app
  await CacheHelper.init();

  Widget widget = const SplashScreen();

//here we go to cache helper and ask you have ON_BOARDING? if its have that means the user logging previousely or see the ON_BOARDING before
  if (CacheHelper.getData(key: AppConstants.ON_BOARDING) != null) {
    //!= null  means user open app before
    if (CacheHelper.getData(key: "userId") == null) {
      // = null user does not open app before
      //run this widget if condition true
      widget = LoginScreen();
    }
  } else {
    //if not run this widget
    widget = OnBoardingScreen();
  }
  // await saveMainArticleToFirestore(mainArticle);
  // await addDoctors(doctors);
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;

  const MyApp({
    Key? key,
    required this.startWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit(),
        ),
        BlocProvider(
          create: (context) => di.sl<LocaleCubit>(instanceName: "LocaleCubit")
            ..getSavedLanguage(),
        ),
      ],
      child: BlocBuilder<LocaleCubit, ChangeLocaleState>(
          buildWhen: (previous, current) => previous.locale != current.locale,
          builder: (context, state) {
            return MaterialApp(
              title: 'Flutter ADHD',
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              home: startWidget,

              supportedLocales: supportedLocales,
              localizationsDelegates: localizationsDelegates,
              localeResolutionCallback: localeResolutionCallback,
              // locale: const Locale('ar'),
              locale: state.locale,
            );
          }),
    );
  }
}
