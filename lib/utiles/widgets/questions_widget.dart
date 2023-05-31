// import 'package:adhd_app/models/category.dart';
// import 'package:adhd_app/models/question.dart';
// import 'package:adhd_app/screens/questionaire/options_widget.dart';
// import 'package:adhd_app/utiles/widgets/intro_questionnaire_screen.dart';
// import 'package:flutter/material.dart';

// import '../../models/option.dart';

// class QuestionsWidget extends StatelessWidget {
//   final Category category;
//   final PageController controller;
//   final ValueChanged<int> onChangedPage;
//   final ValueChanged<Option> onClickedOption;

//   const QuestionsWidget({
//     Key? key,
//     required this.category,
//     required this.controller,
//     required this.onChangedPage,
//     required this.onClickedOption,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) => PageView.builder(
//         onPageChanged: onChangedPage,
//         controller: controller,
//         itemCount: category.questions.length,
//         itemBuilder: (context, index) {
//           final question = category.questions[index];
//           return index == 0 ? IntroQuestionnaireScreen() : buildQuestion(question: question);
//         },
//       );

//   Widget buildQuestion({
//     required Question question,
//   }) =>
//       Container(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 32),
//             Text(
//               question.text,
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
//             ),
//             SizedBox(height: 8),
//             Text(
//               'Choose your answer from below',
//               style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
//             ),
//             SizedBox(height: 32),
//             Expanded(
//               child: OptionsWidget(
//                 question: question,
//                 onClickedOption: onClickedOption,
//               ),
//             ),
//           ],
//         ),
//       );


// }
