import 'package:adhd_app/localization/app_localizations.dart';
import 'package:adhd_app/provider/general_app_cubit/app_general_cubit.dart';
import 'package:adhd_app/screens/home/home_screen.dart';
import 'package:adhd_app/utiles/colors.dart';
import 'package:adhd_app/utiles/components.dart';
import 'package:adhd_app/utiles/widgets/default_form_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../provider/general_app_cubit/states.dart';

class ChildInfoScreen extends StatefulWidget {
  const ChildInfoScreen({Key? key}) : super(key: key);

  @override
  _ChildInfoScreenState createState() => _ChildInfoScreenState();
}

class _ChildInfoScreenState extends State<ChildInfoScreen> {
  int currentStep = 0;
  int? _gender = 0;
  TextEditingController childNameController = TextEditingController();

  void _setValue(int? value) {
    setState(() {
      _gender = value;
      print(_gender);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(listener: (context, state) {
      if (state is ChildAddedErrState) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.error)));
      }

      if (state is ChildAddedSuccessState) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Your child addded Successfully!")));
        AppCubit.get(context).getChildrenInfo();
        navigateAndFinish(context, HomeScreen());
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: Text(
            "Child Information".tr(context),
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white)),
          bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 5),
            child: state is ChildAddedLoadingState
                ? const LinearProgressIndicator()
                : Container(),
          ),
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 20, bottom: 10),
              child: Center(
                child: Text(
                  "Fill your Child Info".tr(context),
                  style: GoogleFonts.lato(
                      fontSize: 19,
                      color: AppColors.mainColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              child: Theme(
                  data: ThemeData(
                      primarySwatch: Colors.purple,
                      colorScheme:
                          ColorScheme.light(primary: AppColors.mainColor)),
                  child: Stepper(
                    type: StepperType.vertical,
                    elevation: 0,
                    currentStep: currentStep,
                    onStepCancel: () => currentStep == 0
                        ? null
                        : setState(() {
                            currentStep -= 1;
                          }),
                    onStepContinue: () {
                      bool isLastStep = (currentStep == getSteps().length - 1);
                      if (isLastStep) {
                        AppCubit.get(context).addChildInfo(
                            gender: _gender == 1 ? 'girl' : 'boy',
                            name: childNameController.text);
                      } else {
                        setState(() {
                          currentStep += 1;
                        });
                      }
                    },
                    onStepTapped: (step) => setState(() {
                      currentStep = step;
                    }),
                    steps: getSteps(),
                  )),
            ),
          ],
        ),
      );
    });
  }

  List<Step> getSteps() {
    List<int> options = [
      5,
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      13,
      14,
      15,
      16,
      17,
      18,
    ];
    return <Step>[
      // step 1 to recevive gender
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: Text("Gender".tr(context)),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "What's your child Gender?".tr(context),
              style: GoogleFonts.lato(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(57, 56, 69, 1),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          spreadRadius: 5,
                          blurRadius: 12,
                          offset: Offset(0, 0))
                    ]),
                child: DropdownButton(
                  itemHeight: 150,
                  icon: const SizedBox.shrink(),
                  value: _gender,
                  underline: Container(),
                  dropdownColor: const Color.fromRGBO(57, 56, 69, 1),
                  onChanged: _setValue,
                  borderRadius: BorderRadius.circular(12),
                  items: [
                    for (var i = 0; i < 2; i++)
                      DropdownMenuItem(
                          value: i,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image(
                                  height: 100,
                                  width: 200,
                                  image: i == 1
                                      ? AssetImage(
                                          "assets/images/G.png",
                                        )
                                      : AssetImage("assets/images/B.png"),
                                  // fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                i == 1 ? 'Girl'.tr(context) : 'Boy'.tr(context),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ))
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 17,
            ),
          ],
        ),
      ),
      //step 2 to receive name
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: Text("Name".tr(context)),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "What's your Child Name?".tr(context),
              style: GoogleFonts.lato(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 17,
            ),
            DefaultFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: childNameController,
              type: TextInputType.text,
              hintText: "Child Name".tr(context),
              label: "Child Name".tr(context),
              borderColor: AppColors.mainColor,
              prefix: FontAwesomeIcons.baby,
              fillColor: Colors.white,
              prefixColorIcon: Colors.black,
              labelColor: Colors.black,
              validate: (String? value) {
                if (value!.isEmpty) {
                  return 'Please enter your Child Name!'.tr(context);
                }
                if (value.length < 2 || value.length > 10) {
                  return 'Name must be between 2 and 10 letters'.tr(context);
                }
                if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                  return 'Name must contain letters only'.tr(context);
                }
                return null;
              },

            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      //step 3 recevive age
      Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 2,
        title: Text("Age".tr(context)),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "What's your Child Age?".tr(context),
              style: GoogleFonts.lato(
                  fontSize: 19,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 17,
            ),
            ChipsChoice<int>.single(
              scrollPhysics: const BouncingScrollPhysics(),
              direction: Axis.horizontal,
              value: AppCubit.get(context).selectedAge,
              choiceItems: C2Choice.listFrom<int, int>(
                source: options,
                value: (i, v) => v,
                label: (i, v) => v.toString(),
              ),
              onChanged: (val) {
//switchAge work when user press on age and it will change by default in app_general_cubit file
                AppCubit.get(context).switchAge(val);
                print(val);
                // setState(() => selectedAge = val.toInt());
              },
            ),
          ],
        ),
      ),
    ];
  }
}
