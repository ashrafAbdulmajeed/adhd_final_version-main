import 'package:adhd_app/localization/app_localizations.dart';
import 'package:adhd_app/screens/questionaire/questions_screen.dart';
import 'package:adhd_app/utiles/app_constants.dart';
import 'package:adhd_app/utiles/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';

class IntroQuestionnaireScreen extends StatelessWidget {
  final String childID;
  final bool isChild;

  const IntroQuestionnaireScreen(
      {Key? key, required this.childID, required this.isChild})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset('assets/images/testIcon.png',
                  width: 200), //testIcon.png
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Are you Ready?".tr(context),
              style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    BoxShadow(
                        color: Color.fromARGB(255, 158, 157, 157),
                        blurRadius: 2)
                  ]),
            ),
            //const Spacer(),
            SizedBox(
              height: 50,
            ),
            filledButtonV2(
                title: "Go to test".tr(context),
                radius: 10.0,
                onPressed: () {
                  navigateTo(
                    context,
                    QuestionsScreen(
                      childID: childID,
                      isChild: isChild,
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
