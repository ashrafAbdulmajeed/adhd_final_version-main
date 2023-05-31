import 'package:adhd_app/screens/child_info/child_info_screen.dart';
import 'package:adhd_app/utiles/widgets/intro_anx.dart';
import 'package:adhd_app/utiles/components.dart';
import 'package:adhd_app/utiles/widgets/intro_questionnaire_screen.dart';
import 'package:flutter/material.dart';
import 'package:adhd_app/screens/home/home_screen.dart';

class AnxCard2 extends StatefulWidget {
  final String childID;
  final bool isChild;
  const AnxCard2({
    required this.childID,
    required this.isChild,
    super.key,
  });

  @override
  State<AnxCard2> createState() => _AnxCard2State();
}

class _AnxCard2State extends State<AnxCard2> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        padding: EdgeInsets.all(20),
        width: 300,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 178, 177, 180),
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/pp.png',
                  fit: BoxFit.cover,
                  width: 80,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text('Predict Anxiety level',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                )),
            IconButton(
              onPressed: () {
                navigateTo(
                  context,
                  IntroAnx(childID: widget.childID, isChild: widget.isChild,),
                );
              },
              icon: Icon(
                Icons.arrow_drop_down_circle_sharp,
                color: Colors.white,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
