// ignore_for_file: prefer_const_constructors, unused_import

import 'package:adhd_app/localization/app_localizations.dart';
import 'package:adhd_app/screens/home/home_screen.dart';

import 'package:adhd_app/screens/questionaire/result_screen.dart';
import 'package:adhd_app/utiles/colors.dart';
import 'package:adhd_app/utiles/components.dart';
import 'package:flutter/material.dart';
import 'package:adhd_app/screens/questionaire/result_anxiety_screen.dart';

import '../more/categories_screen.dart';

class HelpScreen extends StatefulWidget {
  final bool isChild;
  HelpScreen({Key? key, required this.isChild}) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        actions: [
          IconButton(
              onPressed: () {
                navigateTo(
                  context,
                  HomeScreen(),
                );
              },
              icon: Icon(Icons.home_rounded, size: 30, color: Colors.grey[700]))
        ],
      ),
      body: Material(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            Container(
              margin: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(10),
                  color: Color.fromARGB(217, 232, 232, 232)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/c.png',
                        width: 200, height: 100, fit: BoxFit.contain),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Dont Worry! '.tr(context),
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                          color: AppColors.mainColor),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "We will help you to being supportive to your child and take advices in the simplest and easiest way from experts in ADHD, Also there is some fun activity and you can increase your knowledge by reading useful articles."
                          .tr(context),
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: Color.fromARGB(255, 124, 124, 124)),
                    ),
                  ],
                ),
              ),
            ),
            filledButtonV2(
                title: "Continue".tr(context),
                radius: 10.0,
                fullWidth: false,
                onPressed: () {
                  navigateAndFinish(
                      context,
                      CategoriesScreen(
                        isChild: widget.isChild,
                      ));
                })
          ],
        ),
      ),
    );
  }
}
