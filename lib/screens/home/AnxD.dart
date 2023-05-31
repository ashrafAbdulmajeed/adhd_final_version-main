import 'package:adhd_app/localization/app_localizations.dart';
import 'package:flutter/material.dart';

class AnxD extends StatefulWidget {
  const AnxD({super.key});

  @override
  State<AnxD> createState() => _AnxDState();
}

class _AnxDState extends State<AnxD> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      /**no of widget inside TabBarView لازم يوافق عدد الودجت اللي داخل التاب بار فيو*/ length:
          1,
      child: Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: AppBar(
            backgroundColor: Colors.grey[100],
            title: Text('What is Anixety ?'.tr(context),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromARGB(255, 117, 114, 114), fontSize: 25)),
            centerTitle: true,
          ),
          body: TabBarView(
            children: [
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: Padding(
                      padding: const EdgeInsets.all(19.0),
                      child: Text(
                        "anixetyDescription".tr(context),
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Column(
                    children: [],
                  )
                ],
              ),
            ],
          )),
    );
  }
}
