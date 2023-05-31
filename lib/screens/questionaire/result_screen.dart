// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, implementation_imports, depend_on_referenced_packages

import 'package:adhd_app/localization/app_localizations.dart';
import 'package:adhd_app/screens/home/home_screen.dart';
import 'package:adhd_app/screens/questionaire/help_screen.dart';
import 'package:adhd_app/screens/questionaire/anxiety_level_scaler_screen.dart';
import 'package:adhd_app/utiles/app_constants.dart';
import 'package:adhd_app/utiles/colors.dart';
import 'package:adhd_app/utiles/components.dart';
import 'package:adhd_app/utiles/my_functions.dart';
import 'package:adhd_app/utiles/widgets/intro_questionnaire_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResultsScreen extends StatefulWidget {
  final String result;
  final String childID;
  final bool isChild;
  final String resultAr;

  const ResultsScreen(
      {Key? key,
      required this.result,
      required this.childID,
      required this.isChild,
      required this.resultAr})
      : super(key: key);

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: SizedBox(), actions: [
        IconButton(
          icon: Icon(
            Icons.home,
            color: Colors.grey.shade700,
            size: 30,
          ),
          onPressed: () {
            navigateTo(context, HomeScreen());
          },
        ),
      ]),
      body: Material(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/t.png'),
              const SizedBox(
                height: 10,
              ),
              Text(
                "The Result".tr(context),
                style: TextStyle(
                    color: AppColors.mainColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      BoxShadow(
                          color: Color.fromARGB(255, 158, 157, 157),
                          blurRadius: 2)
                    ]),
              ),
              const SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.center,
                child: RichText(
                  textAlign:  TextAlign.center,
                  text: TextSpan(
                    
                    text: 'Your child has:'.tr(context),
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                        color: Colors.black),
                        
                    children: <TextSpan>[
                      TextSpan(
                        text: checkStringLang(
                          ar: widget.resultAr,
                          context: context,
                          en: widget.result,
                        ),
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: widget.result != 'none'
                                ? Colors.red
                                : Colors.green),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  
                  if (widget.result != 'none')
                    filledButtonV2(
                        title: "Get Help".tr(context),
                        radius: 10.0,
                        fullWidth: false,
                        onPressed: () {
                          navigateAndFinish(
                              context,
                              HelpScreen(
                                isChild: widget.isChild,
                              ));
                        }),
                        const SizedBox(
                    width: 20,
                    height: 30,
                  ),
                        if (widget.result != 'none' && !widget.isChild)
                    filledButtonV2(
                        title: "Let's know Anxiety level".tr(context),
                        radius: 10.0,
                        fullWidth: false,
                        onPressed: () {
                          // Go to the next level
                          // AppCubit.get(context).predictAnxietyLevel();
                          navigateAndFinish(
                              context,
                              AnxietyLevelScalerScreen(
                                childID: widget.childID,
                                isChild: widget.isChild,
                              ));
                        }),
                  SizedBox(
                    height: 30,
                  ),
                  IconButton(
                      onPressed: () {
                        navigateTo(
                            context,
                            IntroQuestionnaireScreen(
                              childID: widget.childID,
                              isChild: widget.isChild,
                            ));
                      },
                      icon: Icon(
                        Icons.restart_alt,
                        size: 40,
                        color: Color.fromARGB(255, 84, 143, 115),
                      )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              
              
            ],
          ),
        ),
      ),
    );
  }
}
