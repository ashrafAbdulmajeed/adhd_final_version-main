import 'package:flutter/material.dart';

class QuestionnairesControl extends StatefulWidget {
  const QuestionnairesControl({super.key});

  @override
  State<QuestionnairesControl> createState() => _QuestionnairesControlState();
}

class _QuestionnairesControlState extends State<QuestionnairesControl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('  Questionnaires control',
           textAlign: TextAlign.center,),
          backgroundColor: Colors.grey[300],
        ),
        body: Center(
          child: Text('Questionnaires')
        )
    );
  }
}