import 'package:adhd_app/data/questions.dart';
import 'package:adhd_app/localization/app_localizations.dart';
import 'package:adhd_app/models/question.dart';
import 'package:adhd_app/provider/general_app_cubit/app_general_cubit.dart';
import 'package:adhd_app/provider/general_app_cubit/states.dart';
import 'package:adhd_app/screens/questionaire/result_anxiety_screen.dart';
import 'package:adhd_app/screens/questionaire/result_screen.dart';
import 'package:adhd_app/utiles/app_constants.dart';
import 'package:adhd_app/utiles/colors.dart';
import 'package:adhd_app/utiles/components.dart';
import 'package:adhd_app/utiles/my_functions.dart';
import 'package:adhd_app/utiles/utils.dart';
import 'package:adhd_app/utiles/widgets/checkbox_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionWidget extends StatelessWidget {
  bool forADHD;
  List questions;
  Question question;
  String childID;
  bool isChild;

  CarouselController buttonCarouselController;

  QuestionWidget(
      {required this.forADHD,
      required this.questions,
      required this.question,
      required this.childID,
      required this.isChild,
      required this.buttonCarouselController});

  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(listener: ((context, state) {
      if (state is AdhdResultLoadingState) {
        Utils.showLoaderDialog(context, "Please Wait for the Results...");
      }

      if (state is AdhdResultDoneState) {
        
        navigateAndFinish(
            context,
            ResultsScreen(
              resultAr: state.resultAr,
              result: state.result,
              childID: childID,
              isChild: isChild,
            ));
      }
      if (state is AnxietyLevelSuccessfullyState) {
        
        print(state.message);
        // navigateTo(context, widget)
        navigateAndFinish(
            context,
            ResultsAnxietyScreen(
            levelAr: state.messageAr,
              level: state.message,
              childID: childID,
              isChild: isChild,
            ));
      }
    }), builder: (context, state) {
      AppCubit appCubit = AppCubit.get(context);
      return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${'Question'.tr(context)} ${question.id}",
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        BoxShadow(
                            color: Color.fromARGB(255, 158, 157, 157),
                            blurRadius: 2)
                      ]),
                ),
                const SizedBox(
                  height: 30,
                ),
                getCheckBoxWidget(question),
                const SizedBox(
                  height: 30.0,
                ),
                if ((questions.length) != question.id) actionButton(context),
                if ((questions.length) == question.id &&
                    state is! AdhdResultLoadingState &&
                    state is! AnxietyLevelLoadingState)
                  filledButtonV2(
                      title: "Submit".tr(context),
                      radius: 10.0,
                      onPressed: () {
                        if (forADHD) {
                          AppCubit.get(context).adhdResult(childID);
                        } else {
                          AppCubit.get(context).predictAnxietyLevel(childID);
                        }
                      }),
                if (state is AdhdResultLoadingState)
                  Center(child: const CircularProgressIndicator()),
                if (state is AnxietyLevelLoadingState)
                  Center(child: const CircularProgressIndicator()),
              ]));
    });
  }

  Widget getCheckBoxWidget(Question item) {
    List answers = [];
    item.answerChoices!.entries.forEach((element) {
      answers.add(element);
    });
    print(answers[0].key);

    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            item.question!,
            // textAlign: TextAlign.left,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: answers.length,
              itemBuilder: ((context, index) {
                return addRadioButton(
                    context, answers[index].value, answers[index].key);
              })),
        ]);
  }

  Widget actionButton(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (AppCubit.get(context).listOfChoices.length > 0)
          // ElevatedButton(
          //   // color: AppColors.mainColor,
          //   style: ElevatedButton.styleFrom(
          //     primary: Colors.transparent, // Background color
          //   ),
          //   child: Row(
          //     children: [
          //       Icon(
          //         Icons.arrow_back_ios,
          //         color: Colors.white,
          //         size: 18,
          //       ),
          //       const SizedBox(
          //         width: 5,
          //         height: 10,
          //       ),
          //     ],
          //   ),
          //   onPressed: () => onPrevoiusClick(context),
          // ),
          IconButton(
              onPressed: () => onPrevoiusClick(context),
              icon: Icon(Icons.arrow_back_ios, color: Colors.grey[600])),
        SizedBox(
          width: 180.0,
          height: 100,
        ),
        // ElevatedButton(
        //   style: ElevatedButton.styleFrom(
        //     primary: Colors.transparent, // Background color
        //   ),
        //   child: Row(
        //     children: [
        //       const SizedBox(
        //         width: 5,
        //       ),
        //       Icon(
        //         Icons.arrow_forward_ios,
        //         color: Colors.white,
        //         size: 18,
        //       )
        //     ],
        //   ),
        //   onPressed: () => onNextClick(context),
        // ),
        IconButton(
            onPressed: () => onNextClick(context),
            icon: Icon(Icons.arrow_forward_ios, color: Colors.grey[600]))
      ],
    );
  }

  onNextClick(context) {
    AppCubit.get(context).addNewChoice(forADHD);
    buttonCarouselController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  onPrevoiusClick(context) {
    AppCubit.get(context).deleteChoice(forADHD);
    buttonCarouselController.previousPage(
        duration: Duration(milliseconds: 300), curve: Curves.linear);
  }

  Row addRadioButton(context, int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: AppColors.mainColor,
          value: btnValue,
          groupValue: AppCubit.get(context).answerSelected,
          onChanged: (value) {
            AppCubit.get(context).switchAnswer(value);
          },
        ),
        Text(
          title,
          style: const TextStyle(fontFamily: 'Cairo'),
        )
      ],
    );
  }
}
