import 'package:adhd_app/localization/app_localizations.dart';
import 'package:adhd_app/screens/child_info/child_info_screen.dart';
import 'package:adhd_app/utiles/components.dart';
import 'package:flutter/material.dart';
import 'package:adhd_app/screens/home/home_screen.dart';

class MyCard1 extends StatefulWidget {
  const MyCard1({
    super.key,
  });

  @override
  State<MyCard1> createState() => _MyCard1State();
}

class _MyCard1State extends State<MyCard1> {
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
                  //'assets/images/a.png',
                  'assets/images/info.png',
                  fit: BoxFit.cover,
                  width: 80,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text('Add child info'.tr(context),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                )),
            Expanded(
              child: IconButton(
                onPressed: () {
                  navigateTo(
                    context,
                    const ChildInfoScreen(),
                  );
                },
                icon: Icon(Icons.add, size: 30, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
