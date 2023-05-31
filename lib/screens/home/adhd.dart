import 'package:adhd_app/localization/app_localizations.dart';
import 'package:flutter/material.dart';

class Adef extends StatefulWidget {
  const Adef({super.key});

  @override
  State<Adef> createState() => _AdefState();
}

class _AdefState extends State<Adef> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      /**no of widget inside TabBarView لازم يوافق عدد الودجت اللي داخل التاب بار فيو*/ length:
          1,
      child: Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: AppBar(
            backgroundColor: Colors.grey[100],
            title: Text('What is ADHD?'.tr(context),
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
                        'Attention Deficit Hypeactivity Disorder is one of the most common neurodevelopmental disorders of childhood. It is usually first diagnosed in childhood and often lasts into adulthood. Children with ADHD may have trouble paying attention, controlling impulsive behaviors (may act without thinking about what the result will be), or be overly active.'
                            .tr(context),
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w300),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
