import 'package:adhd_app/localization/app_localizations.dart';
import 'package:adhd_app/screens/child_info/child_info_screen.dart';
import 'package:adhd_app/utiles/components.dart';
import 'package:flutter/material.dart';
import 'package:adhd_app/screens/home/home_screen.dart';
import 'package:adhd_app/screens/home/adhd.dart';

class MyCard3 extends StatefulWidget {
  const MyCard3({
    super.key,
  });

  @override
  State<MyCard3> createState() => _MyCard3State();
}

class _MyCard3State extends State<MyCard3> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        padding: const EdgeInsets.all(20),
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
                  'assets/images/qM.png',
                  fit: BoxFit.cover,
                  width: 80,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text('What is ADHD?'.tr(context),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                )),
            Expanded(
              child: IconButton(
                onPressed: () {
                  navigateTo(
                    context,
                    const Adef(),
                  );
                },
                icon: const Icon(Icons.arrow_forward_ios,
                    size: 30, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
