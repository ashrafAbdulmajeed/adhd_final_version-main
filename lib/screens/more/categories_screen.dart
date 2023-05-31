import 'package:adhd_app/localization/app_localizations.dart';
import 'package:adhd_app/screens/fun_activities/fun_activity_screen.dart';
import 'package:adhd_app/screens/home/home_screen.dart';
import 'package:adhd_app/screens/more/articles_screen.dart';
import 'package:adhd_app/screens/specialists/specialists_screen.dart';
import 'package:adhd_app/utiles/colors.dart';
import 'package:adhd_app/utiles/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:adhd_app/screens/questionaire/help_screen.dart';

class CategoriesScreen extends StatefulWidget {
  final bool isChild;
  const CategoriesScreen({Key? key, required this.isChild}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              onPressed: () {
                navigateTo(context, HomeScreen());
              },
              icon: Icon(Icons.home),
              color: Color.fromARGB(255, 96, 94, 94),
              iconSize: 30,
            ),
          ],
          leading: IconButton(
              onPressed: () {
                // Navigator.pop(context);
                navigateTo(
                    context,
                    HelpScreen(
                      isChild: widget.isChild,
                    ));
              },
              icon: Icon(Icons.arrow_back_ios))),
      body: Material(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Tips".tr(context),
                    style: TextStyle(
                        color: AppColors.mainColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // boxItem(context, "Better Help",
                  //     "Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec velit neque, auctor sit amet aliquam vel, ullamcorper sit amet ligula.",
                  //     () {
                  //   navigateTo(context, HelpScreen());
                  // }),
                  const SizedBox(
                    height: 10,
                  ),
                  boxItem(
                      context,
                      "Fun Activities".tr(context),
                      "Here you will find a funny game for your child to be more concentrate"
                          .tr(context), () {
                    navigateTo(context, FunActivity());
                  }),
                  const SizedBox(
                    height: 40,
                  ),
                  boxItem(
                      context,
                      "Read Articles".tr(context),
                      "Here you will find useful articles that help you how to deals with your child .".tr(context)
, () {
                    navigateTo(context, ArticlesScreen());
                  }),

                  const SizedBox(
                    height: 40,
                  ),
                  boxItem(
                      context,
                      "Contact With Specialists".tr(context),
                      "you can contact with doctors if you want to ask about your child condition"
                          .tr(context), () {
                    navigateTo(context, SpecialistsScreen());
                  }),
                  const SizedBox(
                    height: 40,
                  ),
                  // filledButtonV2(
                  //     title: "Go Home",
                  //     radius: 10.0,
                  //     fullWidth: true,
                  //     onPressed: () {
                  //       navigateAndFinish(context, HomeScreen());
                  //     }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // box Item
  Widget boxItem(context, String title, String description, onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsetsDirectional.only(
          top: 15,
          bottom: 15,
          start: 20,
          end: 20,
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadiusDirectional.circular(20),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 0),
                color: Color.fromARGB(106, 206, 206, 206),
                blurRadius: 7.0,
              ),
            ]),
        child: Center(
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                    color: AppColors.mainColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                description,
                style:const  TextStyle(
                    color: Colors.black45,
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
