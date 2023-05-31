import 'package:adhd_app/injection_container.dart';
import 'package:adhd_app/localization/app_localizations.dart';
import 'package:adhd_app/models/user_model.dart';
import 'package:adhd_app/utiles/colors.dart';
import 'package:adhd_app/utiles/widgets/default_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utiles/my_functions.dart';

class UpdateUserScreen extends StatefulWidget {
  const UpdateUserScreen({Key? key, required this.userModel}) : super(key: key);
  final UserModel userModel;
  @override
  State<UpdateUserScreen> createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController userConfirmPassword = TextEditingController();
  TextEditingController userPassword = TextEditingController();
  bool secureText = false;
  bool isLoading = false;
  String role = '';

  @override
  void initState() {
    usernameController.text = widget.userModel.username.toString();
    phoneNumberController.text = widget.userModel.phone.toString();
    emailController.text = widget.userModel.email.toString();
    userPassword.text = widget.userModel.password.toString();
    role = widget.userModel.role ?? "Normal";
    print("=====>$role");
    // userConfirmPassword.text=widget.userModel.p
    // TODO: implement initState
    super.initState();
  }

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Form(
            child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(
                  widget.userModel.image.toString(),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Center(
                child: Text(
                  "Update User",

                  // 'Hello'.tr(context),
                  style: TextStyle(
                    fontSize: 30.0,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w600,
                    color: AppColors.mainColor,
                  ),
                ),
              ),

              const SizedBox(
                height: 25,
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
                    return 'Name must be between 2 and 10 letters'.tr(context);
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
                    return "please enter a valid Email format".tr(context);
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
                    return 'Please enter again the password!'.tr(context);
                  }

                  if (userPassword.text != userConfirmPassword.text) {
                    return 'The Passwords does not match'.tr(context);
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              StatefulBuilder(builder: (context, state) {
                return Row(
                  children: [
                    Text(
                      "UserType :   ",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    DropdownButton(
                        // underline: ,
                        elevation: 0,
                        // disabledHint: true,
                        style: TextStyle(
                          color: AppColors.mainColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                        // style: TextStyle(color: Colors.white),
                        autofocus: false,
                        value: role,
                        focusColor: Colors.white,
                        // dropdownColor: Color.fromARGB(255, 126, 88, 88),
                        items: ['Normal', 'admin']
                            .map((e) => DropdownMenuItem<String>(
                                  enabled: true,
                                  alignment: AlignmentDirectional.center,
                                  value: e,
                                  child: Text(e.toString()),
                                ))
                            .toList(),
                        onChanged: (newValue) {
                          if (newValue != null) {
                            state(() {
                              role = newValue.toString();
                            });
                            print(newValue);
                          }
                        }),
                  ],
                );
              }),
              const SizedBox(
                height: 40,
              ),

              isLoading
                  ? const CircularProgressIndicator.adaptive()
                  : SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.width * 0.1,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.mainColor,
                        ),
                        onPressed: () {
                          final userData = widget.userModel.copyWith(
                              username: usernameController.text,
                              email: emailController.text,
                              phone: phoneNumberController.text,
                              password: userPassword.text,
                              role: role);
                          updateUserInformation(
                            userId: widget.userModel.id.toString(),
                            updatedData: userData.toMap(),
                          );
                        },
                        child: Text(
                          'Update',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      ),
                    ),
            ],
          ),
        )),
      ),
    );
  }

  updateUserInformation(
      {required String userId,
      required Map<String, dynamic> updatedData}) async {
    try {
      setState(() {
        isLoading = true;
      });
      await sl<FirebaseFirestore>()
          .collection('users')
          .doc(userId)
          .update(updatedData)
          .then(
            (value) => setState(
              () {
                isLoading = false;
              },
            ),
          )
          .whenComplete(
        () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Updated SuccessFully"),
            ),
          );
        },
      );
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message.toString(),
          ),
        ),
      );
    }
  }
}
