import 'package:adhd_app/localization/app_localizations.dart';
import 'package:adhd_app/provider/general_app_cubit/app_general_cubit.dart';
import 'package:adhd_app/screens/auth/login_screen.dart';
import 'package:adhd_app/utiles/colors.dart';
import 'package:adhd_app/utiles/components.dart';
import 'package:adhd_app/utiles/widgets/default_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../provider/general_app_cubit/states.dart';
import '../../utiles/my_functions.dart';

class RegisterScreen extends StatelessWidget {
  //initialize the variables
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userConfirmPassword = TextEditingController();
  TextEditingController userPassword = TextEditingController();
  bool secureText = true;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

//var
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //use bloc , its like set state , help to add anything to screens without to do reload
    return BlocConsumer<AppCubit, AppStates>(
      listener: ((context, state) {
        if (state is AppRegisterErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }

        if (state is AppRegisterSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Registration Successfully!, Login Now")));
          //naviagation
          navigateAndFinish(context, LoginScreen());
        }
      }),
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Image(
                        image: AssetImage('assets/images/LO.png'),
                        height: 100.0,
                        width: double.infinity,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Center(
                        child: Text(
                          'Hello'.tr(context),
                          style: TextStyle(
                            fontSize: 30.0,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w600,
                            color: AppColors.mainColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Center(
                        child: Text(
                          'Please complete the registration to login!'
                              .tr(context),
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),

                      DefaultFormField(
                        controller: usernameController,
                        type: TextInputType.text,
                        hintText: "Name".tr(context),
                        label: "Name".tr(context),
                        borderColor: AppColors.mainColor,
                        prefix: FontAwesomeIcons.user,
                        fillColor: Colors.white,
                        labelColor: Colors.black54,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Name is required'.tr(context);
                          }

                          if (value.length < 2 || value.length > 10) {
                            return 'Name must be between 2 and 10 letters'
                                .tr(context);
                          }
                          if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                            return 'Name must contain letters only'.tr(context);
                          }

                          // Regex pattern to validate name format

                          return null;
                        },
                      ),

                      const SizedBox(
                        height: 15.0,
                      ),
                      //take it from widgets inputs
                      DefaultFormField(
                        //calling
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        hintText: "example@example.com",
                        prefix: FontAwesomeIcons.envelope,
                        label: "Email".tr(context),
                        borderColor: AppColors.mainColor,
                        fillColor: Colors.white,
                        labelColor: Colors.black54,
                        //to check
                        validate: (String? value) {
                          validateEmail(value);
                          if (value!.isEmpty) {
                            return "Please enter your email!".tr(context);
                          }
                          if (!RegExp(
                                  r'^[a-zA-Z0-9._%+-]+@(gmail|hotmail|outlook|icloud|kku)\.(com|edu\.sa)$')
                              .hasMatch(value)) {
                            return "please enter a valid Email format"
                                .tr(context);
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      DefaultFormField(
                        controller: phoneNumberController,
                        type: TextInputType.text,
                        hintText: "05xxxxxxxx",
                        label: "Phone number".tr(context),
                        prefix: FontAwesomeIcons.phone,
                        borderColor: AppColors.mainColor,
                        fillColor: Colors.white,
                        labelColor: Colors.black54,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Phone number is required'.tr(context);
                          }
                          // Regex pattern to validate phone number format and check for characters
                          String pattern = r'^[0-9]+$';
                          RegExp regExp = RegExp(pattern);
                          if (!regExp.hasMatch(value)) {
                            return 'please enter numbers only'.tr(context);
                          }
                          if (!value.startsWith("05")) {
                            return 'Please enter SA number'.tr(context);
                          }
                          if (value.length > 10) {
                            return 'please enter 10 numbers only'.tr(context);
                          }

                          if (value.length < 10) {
                            return 'please enter 10 numbers'.tr(context);
                          }

                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      DefaultFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: userPassword,

                        // suffixIcon: IconButton(
                        //   onPressed: (){

                        // },
                        //  icon: Icon(Icons.visibility_off)
                        //  ) ,
                        isPassword: true,
                        type: TextInputType.visiblePassword,
                        hintText: "**********",
                        label: "Password".tr(context),
                        prefix: FontAwesomeIcons.lock,
                        borderColor: AppColors.mainColor,
                        fillColor: Colors.white,
                        maxLines: 1,
                        onChange: (val) {
                          formkey.currentState?.validate();
                        },
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter password!'.tr(context);
                          }
                          //RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{10,30}$')
                          if (!RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{10,30}$')
                              .hasMatch(value)) {
                            return checkStringLang(
                                ar: 'كلمة سر غير متوقعه , يجب ان تحتوي على  :'
                                    '\n - 10 احرف على الاقل و 30 على الاكثر'
                                    '\n - حرف كبير واحد على الاقل  '
                                    '\n - رقم واحد على الاقل'
                                    '\n - رمز واحد على الاقل(? # @ & % ! *) ',
                                en: 'UnAcceptabel password , it must contain :'
                                    '\n - 10 characters at least and 30 characters at most'
                                    '\n - One Capital letter at least  '
                                    '\n - One number at least'
                                    '\n - One symbol at least (? # @ & % ! *) ',
                                context: context);
                          }

                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),

                      DefaultFormField(
                        controller: userConfirmPassword,
                        isPassword: true,
                        type: TextInputType.visiblePassword,
                        hintText: "***",
                        label: " Confirm Password".tr(context),
                        prefix: FontAwesomeIcons.lock,
                        borderColor: AppColors.mainColor,
                        fillColor: Colors.white,
                        maxLines: 1,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter again the password!'
                                .tr(context);
                          }

                          if (userPassword.text != userConfirmPassword.text) {
                            return 'The Passwords does not match'.tr(context);
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! AppRegisterLoadingState,
                        builder: (context) => filledButtonV2(
                            title: "Register".tr(context),
                            radius: 5.0,
                            onPressed: () {
                              //validate from inputs
                              if (formKey.currentState!.validate()) {
                                //if true? then register
                                AppCubit.get(context).userRegister(
                                  name: usernameController.text,
                                  phone: phoneNumberController.text,
                                  email: emailController.text,
                                  password: userPassword.text,
                                );
                              }
                            }),
                        fallback: (context) => Center(
                            child: CircularProgressIndicator(
                          color: AppColors.mainColor,
                        )),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Have an account?'.tr(context),
                            style: const TextStyle(
                                color: Color.fromARGB(255, 136, 136, 136),
                                fontSize: 17.0),
                          ),
                          TextButton(
                              onPressed: () {
                                navigateTo(context, LoginScreen());
                              },
                              child: Text(
                                "Login".tr(context),
                                style: TextStyle(
                                    color: AppColors.mainColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.0),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'+/=?^_`{|}~-]+)|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])")@(?:(?:[a-z0-9](?:[a-z0-9-]'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return (value!.isNotEmpty && !regex.hasMatch(value)) || value.isEmpty
        ? "Please Enter Valid Email"
        : null;
  }
}

Future<bool> checkIfPhoneNumberIsExist(String phone) async {
  final doc = await FirebaseFirestore.instance
      .collection('usersPhonesNumber')
      .doc(phone)
      .get();
  return doc.exists;
}
