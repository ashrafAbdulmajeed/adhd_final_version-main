import 'package:adhd_app/screens/questionaire/anxiety_level_scaler_screen.dart';
import 'package:adhd_app/screens/questionaire/questions_screen.dart';
import 'package:adhd_app/utiles/app_constants.dart';
import 'package:adhd_app/utiles/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';

class IntroAnx extends StatelessWidget {
  final String childID;
  final bool isChild;
  const IntroAnx({Key? key, required this.childID, required this.isChild}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset('assets/images/Q.jpg'),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "Are you Ready? ",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    BoxShadow(
                        color: Color.fromARGB(255, 158, 157, 157),
                        blurRadius: 2)
                  ]),
            ),
            SizedBox(
              height: 15,
            ),
            const Text(
              "To predict your child (teenager) Anxiety! ",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  //fontWeight: FontWeight.bold,
                  shadows: [
                    BoxShadow(
                        color: Color.fromARGB(255, 158, 157, 157),
                        blurRadius: 2)
                  ]),
              textAlign: TextAlign.center,
            ),
            //const Spacer(),
            SizedBox(
              height: 50,
            ),
            filledButtonV2(
                title: "Take the questionnaire",
                radius: 10.0,
                onPressed: () {
                  navigateTo(context, AnxietyLevelScalerScreen(childID: childID, isChild: isChild,));
                }),
          ],
        ),
      ),
    );
  }
}
