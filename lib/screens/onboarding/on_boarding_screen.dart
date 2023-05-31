import 'package:adhd_app/localization/app_localizations.dart';
import 'package:adhd_app/screens/auth/login_screen.dart';
import 'package:adhd_app/utiles/app_constants.dart';
import 'package:adhd_app/utiles/colors.dart';
import 'package:adhd_app/utiles/components.dart';
import 'package:adhd_app/utiles/network/local/cache_helper.dart';
import 'package:adhd_app/utiles/widgets/vertical_spacer.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../utiles/widgets/language_switch.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.title,
    required this.image,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'h.png',
      title: 'onBoradingWelcome',
      body: "ADHD Awareness",
    ),
    BoardingModel(
        image: 'chh.png', title: "onBoardingTitle2", body: "onBoardingBody2"),
    BoardingModel(
      image: 'j1.png',
      title: "onBoradingTitle3",
      body: "onBoardingBody3",
    ),
    BoardingModel(
      image: 'j2.png',
      title: "onBoardingTitle4",
      body: "",
    ),
  ];

  bool isLast = false;

  void submit() {
    //save data that user was see the ON_BOARDING before
    CacheHelper.saveData(
      key: AppConstants.ON_BOARDING,
      value: true,
    ).then((value) {
      if (value) {
        navigateAndFinish(
          context,
          LoginScreen(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: const SwitchLanguage(),
        actions: [
          const SizedBox(
            width: 10,
          ),
          const SwitchLanguage(),
          const Spacer(),
          if (!isLast)
            TextButton(
              onPressed: submit,
              child: Text(
                'SKIP'.tr(context),
                style: TextStyle(
                  color: AppColors.mainColor,
                ),
              ),
            ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index], index),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  effect: WormEffect(
                    activeDotColor: AppColors.mainColor,
                    dotWidth: 12,
                    dotHeight: 12,
                  ),
                  count: boarding.length,
                ),
                const Spacer(),
                if (isLast)
                  filledButton(context,
                      title: "Get Started".tr(context),
                      txtColor: Colors.white,
                      bgcolor: AppColors.mainColor, onTap: () {
                    submit();
                  }),
                if (!isLast)
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        submit();
                      } else {
                        boardController.nextPage(
                          duration: const Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                    },
                    backgroundColor: AppColors.mainColor,
                    child: const Icon(
                      Icons.arrow_forward_ios,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model, int index) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 35,
          ),
          SizedBox(
            width: 375,
            height: isLast ? 100 : 150,
            child: FittedBox(
              fit: BoxFit.cover,
              child: Image.asset(
                'assets/onboarding/${model.image}',
                height: 100,
                width: 100,
              ),
            ),
          ),
          const VerticalSpacer(height: 40),
          Text(
            model.title.tr(context),
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 25,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          const VerticalSpacer(height: 8),
          SizedBox(
            width: 240,
            child: Text(
              model.body.tr(context),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
}
