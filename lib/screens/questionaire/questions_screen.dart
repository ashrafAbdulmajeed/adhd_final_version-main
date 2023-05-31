import 'package:adhd_app/data/questions.dart' as questions;
import 'package:adhd_app/utiles/widgets/question_widget.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class QuestionsScreen extends StatefulWidget {
  final String childID;
  final bool isChild;
  const QuestionsScreen({Key? key, required this.childID, required this.isChild}) : super(key: key);
  
  
  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  CarouselController buttonCarouselController = CarouselController();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    // List<QuestionResult> _questionResults = [];
    print(widget.isChild);
    return Scaffold(
      body: Stack(
        children: [
          //slider with swipe
          CarouselSlider(
            carouselController: buttonCarouselController,
            options: CarouselOptions(
                height: MediaQuery.of(context).size.height - 100,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                reverse: false,
                scrollPhysics: const NeverScrollableScrollPhysics()
                // autoPlay: false,
                ),
            items: widget.isChild ? questions.questionsADHD2(context)
                .map((item) => Center(
                    child: QuestionWidget(
                        forADHD: true,
                        childID: widget.childID,
                        isChild: widget.isChild,
                        questions: questions.questionsADHD2(context),
                        question: item,
                        buttonCarouselController: buttonCarouselController)))
                .toList() : questions.questionsADHDTeenager2(context)
                .map((item) => Center(
                    child: QuestionWidget(
                        forADHD: true,
                        childID: widget.childID,
                        isChild: widget.isChild,
                      
                        questions: questions.questionsADHD2(context),
                        question: item,
                        buttonCarouselController: buttonCarouselController)))
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
