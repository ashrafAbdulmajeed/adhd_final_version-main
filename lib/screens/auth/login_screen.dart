// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:adhd_app/admin_panel/admin.dart';
import 'package:adhd_app/localization/app_localizations.dart';
import 'package:adhd_app/provider/general_app_cubit/app_general_cubit.dart';
import 'package:adhd_app/screens/auth/register_screen.dart';
import 'package:adhd_app/screens/home/home_screen.dart';
import 'package:adhd_app/utiles/colors.dart';
import 'package:adhd_app/utiles/components.dart';
import 'package:adhd_app/utiles/my_functions.dart';
import 'package:adhd_app/utiles/network/local/cache_helper.dart';
import 'package:adhd_app/utiles/widgets/default_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../provider/general_app_cubit/states.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  bool secureText = true;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: ((context, state) {
      if (state is AppRegisterErrorState) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.error)));
      }

      if (state is SignInWithGoogleFailed) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.error)));
      }

      if (state is AppLoginSuccessState) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Login Successfully!")));
        //*******************new
        ///TODO
        ///here will be the checking of the user if the use is an admin navigate to admin panel else to HomeScreen
        FirebaseFirestore.instance
            .collection('users')
            .doc(state.uId)
            .get()
            .then((value) {
          if (value.data() != null && value.data()!['role'] == 'admin') {
            showCustomAwesomeDialog(
                context: context,
                title: "Welcome Admin",
                message:
                    "Do You Want to continue to Admin Panel Press Continue as Admin.\n else Go to Home Screen Press Continue as User",
                btnCancelText: "Continue as User",
                btnOkText: "Continue as Admin",
                btnOkOnPress: () {
                  navigateAndFinish(context, AdminScreen());
                },
                btnCancelOnPress: () {
                  navigateAndFinish(context, HomeScreen());
                });
          } else {
            navigateAndFinish(context, HomeScreen());
          }
        });
        //*******************new
        ///old
        // navigateAndFinish(context, HomeScreen());
        ///old
      }
    }), builder: (context, state) {
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Image(
                      image: AssetImage('assets/images/LO.png'),
                      height: 100.0,
                      width: double.infinity,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: Text(
                        'Login'.tr(context),
                        style: TextStyle(
                          fontSize: 30.0,
                          letterSpacing: 3.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.mainColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Center(
                      child: Text(
                        'Please login to your personal account!'.tr(context),
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    // Fields
                    DefaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      hintText: "example@example.com",
                      label: "Email".tr(context),
                      borderColor: AppColors.mainColor,
                      prefix: FontAwesomeIcons.user,
                      fillColor: Colors.white,
                      prefixColorIcon: AppColors.mainColor,
                      labelColor: Colors.grey[600],
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email!'.tr(context);
                        }
                      },
                    ),

                    const SizedBox(
                      height: 20.0,
                    ),
                    // Fields
                    DefaultFormField(
                      controller: passwordController,
                      type: TextInputType.visiblePassword,
                      hintText: "*********",
                      label: "Password".tr(context),
                      borderColor: AppColors.mainColor,
                      prefix: FontAwesomeIcons.lock,
                      fillColor: Colors.white,
                      prefixColorIcon: AppColors.mainColor,
                      labelColor: Colors.grey[600],
                      isPassword: true,
                      maxLines: 1,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your Password!'.tr(context);
                        }
                      },
                    ),

                    const SizedBox(
                      height: 20.0,
                    ),

                    ConditionalBuilder(
                      condition: state is! AppLoginLoadingState,
                      builder: (context) => filledButtonV2(
                          title: "Login".tr(context),
                          radius: 5.0,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              appCubit.userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          }),
                      fallback: (context) => Center(
                          child: CircularProgressIndicator(
                        color: AppColors.mainColor,
                      )),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),

                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Dont Have an account?'.tr(context),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 136, 136, 136),
                              fontSize: 17.0),
                        ),
                        TextButton(
                            onPressed: () {
                              navigateTo(context, RegisterScreen());
                            },
                            child: Text(
                              "Register".tr(context),
                              style: TextStyle(
                                  color: AppColors.mainColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.0),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Login'.tr(context),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 136, 136, 136),
                              fontSize: 17.0),
                        ),
                        TextButton(
                            onPressed: () {
                              navigateTo(context, AdminScreen());
                            },
                            child: Text(
                              "as admin".tr(context),
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
    });
  }
}
// switch (adminUser.permissions) {
// case 1:
// console.log('Admin has add permission');
// break;
// case 2:
// console.log('Admin has delete permission');
// break;
// case 3:
// console.log('Admin has add and delete permission');
// break;
// case 4:
// console.log('Admin has update permission');
// break;
// case 5:
// console.log('Admin has add and update permission');
// break;
// case 6:
// console.log('Admin has delete and update permission');
// break;
// case 7:
// console.log('Admin has all permissions');
// break;
// default:
// console.log('Admin has no permissions');
// break;
// }
