// ignore_for_file: prefer_const_constructors

import 'package:adhd_app/localization/app_localizations.dart';
import 'package:adhd_app/provider/general_app_cubit/app_general_cubit.dart';
import 'package:adhd_app/screens/home/home_screen.dart';
import 'package:adhd_app/screens/questionaire/help_screen.dart';
import 'package:adhd_app/screens/questionaire/anxiety_level_scaler_screen.dart';
import 'package:adhd_app/screens/settings/settings_screen.dart';
import 'package:adhd_app/screens/specialists/specialists_screen.dart';
import 'package:adhd_app/utiles/app_constants.dart';
import 'package:adhd_app/utiles/colors.dart';
import 'package:adhd_app/utiles/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../utiles/my_functions.dart';

class ResultsAnxietyScreen extends StatefulWidget {
  final String level;
  final String childID;
  final bool isChild;
  final String levelAr;

  const ResultsAnxietyScreen(
      {Key? key,
      required this.level,
      required this.childID,
      required this.isChild,
      required this.levelAr})
      : super(key: key);

  @override
  State<ResultsAnxietyScreen> createState() => _ResultsAnxietyScreenState();
}

class _ResultsAnxietyScreenState extends State<ResultsAnxietyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        actions: [
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
        ],
      ),
      body: Material(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 20.0, bottom: 20.0, right: 20, left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/t.png'),
              const SizedBox(
                height: 40,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(10),
                    color: Color.fromARGB(217, 232, 232, 232)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'The Anxiety level for your child:'.tr(context),
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${checkStringLang(
                          ar: widget.levelAr,
                          context: context,
                          en: widget.level,
                        )}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: AppColors.mainColor),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        navigateTo(
                            context,
                            AnxietyLevelScalerScreen(
                              childID: widget.childID,
                              isChild: widget.isChild,
                            ));
                      },
                      icon: Icon(
                        Icons.restart_alt,
                        size: 30,
                        color: Color.fromARGB(255, 84, 143, 115),
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  filledButtonV2(
                      title: "Get Help".tr(context),
                      radius: 10.0,
                      fullWidth: false,
                      onPressed: () {
                        navigateAndFinish(context, SpecialistsScreen());
                      }),
                  const SizedBox(
                    width: 60,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
