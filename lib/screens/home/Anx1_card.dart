import 'package:adhd_app/localization/app_localizations.dart';
import 'package:adhd_app/screens/child_info/child_info_screen.dart';
import 'package:adhd_app/screens/home/AnxD.dart';
import 'package:adhd_app/utiles/components.dart';
import 'package:adhd_app/utiles/widgets/intro_questionnaire_screen.dart';
import 'package:flutter/material.dart';
import 'package:adhd_app/screens/home/home_screen.dart';

class AnxCard1 extends StatefulWidget {
  const AnxCard1({
    super.key,
  });

  @override
  State<AnxCard1> createState() => _AnxCard1State();
}

class _AnxCard1State extends State<AnxCard1> {
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
                Image.asset('assets/images/Anxx.png',
                    fit: BoxFit.cover, width: 82),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text('What is Anxiety?'.tr(context),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                )),
            Expanded(
              child: IconButton(
                onPressed: () {
                  navigateTo(
                    context,
                    AnxD(),
                  );
                },
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
