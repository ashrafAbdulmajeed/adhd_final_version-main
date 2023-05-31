import 'package:adhd_app/data/questions.dart' as questions;
import 'package:adhd_app/utiles/widgets/question_widget.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AnxietyLevelScalerScreen extends StatefulWidget {
  final String childID;
  final bool isChild;
  const AnxietyLevelScalerScreen({Key? key, required this.childID, required this.isChild}) : super(key: key);

  @override
  _AnxietyLevelScalerScreenState createState() =>
      _AnxietyLevelScalerScreenState();
}

class _AnxietyLevelScalerScreenState extends State<AnxietyLevelScalerScreen> {
  CarouselController buttonCarouselController = CarouselController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    // List<QuestionResult> _questionResults = [];
    return Scaffold(
      body: Stack(
        children: [
          CarouselSlider(
            carouselController: buttonCarouselController,
            options: CarouselOptions(
                height: MediaQuery.of(context).size.height - 100,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                reverse: false,
                scrollPhysics: NeverScrollableScrollPhysics()
                // autoPlay: false,
                ),
            items: questions.questionsOfAnxietyLevel2(context)
                .map((item) => Container(
                      child: Center(
                          child: QuestionWidget(
                            childID: widget.childID,
                            isChild: widget.isChild,
                            forADHD: false,
                              questions: questions.questionsOfAnxietyLevel2(context),
                              question: item,
                              buttonCarouselController:
                                  buttonCarouselController)),
                    ))
                .toList(),
          ),
          // Align(
          //   alignment: Alignment.bottomRight,
          //   child: Image.asset(
          //     "assets/images/question.png",
          //     width: 200,
          //     height: 150,
          //   ),
          // )
        ],
      ),
    );
  }
}
