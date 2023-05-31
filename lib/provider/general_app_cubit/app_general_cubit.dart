// ignore_for_file: depend_on_referenced_packages, unnecessary_import, unused_import

import 'dart:convert';
import 'dart:io';

import 'package:adhd_app/localization/app_localizations.dart';
import 'package:adhd_app/models/child_info.dart';
import 'package:adhd_app/models/user_model.dart';
import 'package:adhd_app/provider/general_app_cubit/states.dart';
import 'package:adhd_app/screens/auth/login_screen.dart';
import 'package:adhd_app/screens/auth/register_screen.dart';
import 'package:adhd_app/screens/home/home_screen.dart';
import 'package:adhd_app/utiles/app_constants.dart';
import 'package:adhd_app/utiles/components.dart';
import 'package:adhd_app/utiles/network/local/cache_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http; //to use in API

const List<String> anxietyResultLevels = [
  "Low Anxiety",
  "Moderate Anxiety "
      "Mild Anxiety"
      "Severe Anxiety"
];

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;

    emit(ChangePasswordVisibilityState());
  }

  int selectedAge = 2;
  void switchAge(val) {
    selectedAge = val;

    emit(ChangeSelectedAgeState());
  }

  int answerSelected = 1;
  void switchAnswer(value) {
    answerSelected = value;
    emit(AnswerSelectedState());
  }

  List listOfChoices = [];
  void addNewChoice(forADHD) {
    if (forADHD) {
      //answers for ADHD we follow this way to calculate
      if (answerSelected <= 2) {
        listOfChoices.add(1);
      } else {
        listOfChoices.add(0);
      }
    } else {
      //answers for anxiety
      listOfChoices.add(answerSelected);
    }

    answerSelected = 1;

    print(listOfChoices);
    emit(AnswerSelectedState());
  }

  void deleteChoice(forADHD) {
    listOfChoices.removeLast();
    print(listOfChoices);
    emit(RemoveLastItemState());
  }

////////////////////////////////////
  ///result of ADHD
  adhdResult(childId) {
    emit(AdhdResultLoadingState());
    addNewChoice(true);
    List first9Answers = listOfChoices.getRange(0, 8).toList();
    List second9Answers = listOfChoices.getRange(9, 17).toList();
    var sumOffirst9Answers = first9Answers.reduce((a, b) => a + b);
    var sumOflast9Answers = second9Answers.reduce((a, b) => a + b);

    // var sum = listOfChoices.reduce((a, b) => a + b);
    // print(sum);
    var result = "none";
    var resultAr = "ليس لديه شي";
    if (sumOffirst9Answers >= 6) {
      result = " ADHD (inattentive)";
      resultAr = " فرط حركة ونقص الانتباه من نوع (غافل)";
    }
    if (sumOflast9Answers >= 6) {
      result = " ADHD (hyperactive)";
      resultAr = " فرط حركة ونقص الانتباه من نوع (فعال بصوره زائده)";
    }
    if (sumOffirst9Answers >= 6 && sumOflast9Answers >= 6) {
      result = " ADHD (both inattentive & hyperactive)";
      resultAr = " فرط حركة ونقص الانتباه من نوع (فعال بصوره زائده + غافل)";
    }

    FirebaseFirestore.instance
        .collection('users')
        .doc(CacheHelper.getData(key: "userId"))
        .collection('children')
        .doc(childId)
        .update({"adhdResult": result, "resultAr": resultAr});

    listOfChoices = [];
    emit(AdhdResultDoneState(result, resultAr));
    print(result);

    return result;
  }
//////////////////////////////////

//////////////////////////
//if user get to last answers , this function will work
  Future predictAnxietyLevel(childId) async {
    emit(AnxietyLevelLoadingState());
    addNewChoice(false);
    print(listOfChoices);
    //Add API
    final response = await http
        .post(Uri.parse("http://test2000.pythonanywhere.com/predict"), body: {
      "values": '$listOfChoices',
      // "values": '[1, 2, 3, 4, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4]',
    }, headers: {});
    print(response.body);

    final result = json.decode(response.body);
    String resultAr = "none";
    if (response.statusCode == 200) {
      switch (result['data']) {
        case "Low Anxiety":
          resultAr = "قلق منخفض";
          break;
        case "Moderate Anxiety":
          resultAr = "قلق متوسط";
          break;
        case "Mild Anxiety":
          resultAr = "قلق عالي";
          break;
        case "Severe Anxiety":
          resultAr = "قلق عالي جدا";
          break;
      }
      debugPrint(result['data'].toString());
      FirebaseFirestore.instance
          .collection('users')
          .doc(CacheHelper.getData(key: "userId"))
          .collection('children')
          .doc(childId)
          .update({"levelResult": result['data'], "levelResultAr": resultAr});
      emit(AnxietyLevelSuccessfullyState(
          message: result['data'], messageAr: resultAr));
    } else {
      emit(AnxietyLevelFailState(message: "Fail"));
    }
  }
  ///////////////////////////////////

//function
  //TODO
  Future<void> userRegister({
    required String name,
    required String phone,
    required String email,
    required String password,
    String? role,
  }) async {
    //loading that happen after register
    emit(AppRegisterLoadingState());
    //  bool exist=;

    if (await checkIfPhoneNumberIsExist(phone.toString())) {
      emit(AppRegisterErrorState("this number is alredy registered"));
    } else {
//store data on firebase
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        print(value.user);
        createUser(
            uId: value.user!.uid,
            name: name,
            phone: phone,
            email: email,
            password: password,
            role: role);
        FirebaseFirestore.instance
            .collection('usersPhonesNumber')
            .doc(phone)
            .set({"phone": phone, "name": name});
      }).catchError((error) {
        switch (error.code) {
          case "ERROR_EMAIL_ALREADY_IN_USE":
          case "account-exists-with-different-credential":
          case "email-already-in-use":
            error = "Email already used. Go to login page.";
            print(error);
            emit(AppRegisterErrorState(error));
            break;
          case "ERROR_WRONG_PASSWORD":
          case "wrong-password":
            error = "Wrong email/password combination.";
            emit(AppRegisterErrorState(error));
            break;
          case "ERROR_USER_NOT_FOUND":
          case "user-not-found":
            error = "No user found with this email.";
            emit(AppRegisterErrorState(error));
            break;
          case "ERROR_USER_DISABLED":
          case "user-disabled":
            error = "User disabled.";
            emit(AppRegisterErrorState(error));
            break;
          case "ERROR_TOO_MANY_REQUESTS":
          case "operation-not-allowed":
            error = "Too many requests to log into this account.";
            emit(AppRegisterErrorState(error));
            break;
          case "ERROR_OPERATION_NOT_ALLOWED":
          case "operation-not-allowed":
            error = "Server error, please try again later.";
            emit(AppRegisterErrorState(error));
            break;
          case "ERROR_INVALID_EMAIL":
          case "invalid-email":
            error = "Email address is invalid.";
            emit(AppRegisterErrorState(error));
            break;
          default:
            error = "Register failed. Please try again.";
            emit(AppRegisterErrorState(error));
            break;
        }

        print(error.toString());
        emit(AppRegisterErrorState(error.toString()));
      });
    }
  }

//function to create user
  //TODO

  void createUser({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String uId,
    String? role,
    int? permissions,
  }) {
    UserModel model = UserModel.withId(
      username: name,
      phone: phone,
      email: email,
      password: password,
      id: uId,
      image: "assets/images/avatar.jpg",
      isVerfied: false,
      date: DateTime.now().toIso8601String(),
      role: role ?? "Normal",
      permissions: permissions ?? 0,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId.toString())
        .set(model.toMap())
        .then((value) {
      // final encodedModel = jsonEncode(model.toMap());
      // CacheHelper.saveData(
      //   key: "UserData",
      //   value: encodedModel,
      // );

      emit(AppRegisterSuccessState());
    }).catchError((error) {
      //if something error in regiestration
      switch (error.code) {
        case "ERROR_EMAIL_ALREADY_IN_USE":
        case "account-exists-with-different-credential":
        case "email-already-in-use":
          error = "Email already used. Go to login page.";
          print(error);
          emit(AppRegisterErrorState(error));
          break;
        case "ERROR_WRONG_PASSWORD":
        case "wrong-password":
          error = "Wrong email/password combination.";
          emit(AppRegisterErrorState(error));
          break;
        case "ERROR_USER_NOT_FOUND":
        case "user-not-found":
          error = "No user found with this email.";
          emit(AppRegisterErrorState(error));
          break;
        case "ERROR_USER_DISABLED":
        case "user-disabled":
          error = "User disabled.";
          emit(AppRegisterErrorState(error));
          break;
        case "ERROR_TOO_MANY_REQUESTS":
        case "operation-not-allowed":
          error = "Too many requests to log into this account.";
          emit(AppRegisterErrorState(error));
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
        case "operation-not-allowed":
          error = "Server error, please try again later.";
          emit(AppRegisterErrorState(error));
          break;
        case "ERROR_INVALID_EMAIL":
        case "invalid-email":
          error = "Email address is invalid.";
          emit(AppRegisterErrorState(error));
          break;
        default:
          error = "Register failed. Please try again.";
          emit(AppRegisterErrorState(error));
          break;
      }
      print(error.toString());
    });
  }

  void addChildInfo({
    required String gender,
    required String name,
  }) {
    emit(ChildAddedLoadingState());
    if (name.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(CacheHelper.getData(key: "userId"))
          .collection('children')
          .add({
        "gender": gender,
        "name": name,
        "age": selectedAge,
        "adhdResult": '',
        "levelResult": '',
        "isChild": selectedAge > 13 ? false : true
      }).then((value) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(CacheHelper.getData(key: "userId"))
            .collection('children')
            .doc(value.id)
            .update({"id": value.id});
        emit(ChildAddedSuccessState());
      }).catchError((error) {
        emit(ChildAddedErrState(error));
        print(error.toString());
      });
    } else {
      emit(ChildAddedErrState("Please enter child name!"));
    }
  }

  void updateChildInfo({
    required String gender,
    required String name,
    required String id,
  }) {
    emit(ChildUpdatedLoadingState());
    if (name.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(CacheHelper.getData(key: "userId"))
          .collection('children')
          .doc(id)
          .update({
        "gender": gender,
        "name": name,
        "age": selectedAge,
        "isChild": selectedAge > 13 ? false : true
      }).then((value) {
        emit(ChildUpdatedSuccessState());
      }).catchError((error) {
        emit(ChildUpdatedErrState(error.toString()));
        print(error.toString());
      });
    } else {
      emit(ChildUpdatedErrState("Please enter child name!"));
    }
  }

  void removeChildInfo({
    required String id,
  }) {
    print(userId);
    emit(RemoveChildLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(CacheHelper.getData(key: "userId"))
        .collection('children')
        .doc(id)
        .delete()
        .then((value) {
      getChildrenInfo();
      emit(RemoveChildSuccessState());
    }).catchError((error) {
      emit(RemoveChildErrState(error));
      print(error.toString());
    });
  }

  List<ChildModel> children = [];

  void getChildrenInfo() async {
    emit(GetChildrenLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(CacheHelper.getData(key: 'userId'))
        .collection('children')
        .get()
        .then((value) {
      children = [];
      value.docs.forEach((element) {
        children.add(ChildModel.fromJson(element.data()));
      });
      print(children);
      emit(GetChildrenSuccessState());
    }).catchError((error) {
      emit(GetChildrenErrState(error));
      print(error.toString());
    });
  }

//function
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(AppLoginLoadingState());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      print(value.toString());
      //initialize var userId to accessed and global from everywhere
      userId = value.user!.uid;
      //save info to cache to access data when user logout
      final userRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get()
          .then((userRefValue) async {
        if (userRefValue.exists) {
          CacheHelper.saveData(key: "userId", value: userId);
          //TODO
          CacheHelper.saveData(
              key: "role", value: userRefValue.data()!['role'].toString());

          await userInfo(value.user!.uid);
          emit(AppLoginSuccessState(value.user!.uid));
        } else {
          emit(AppRegisterErrorState("This Account Has Been Deleted By Admin"));
        }
      }).catchError((e) {
        emit(AppLoginErrorState(e.toString()));
      });
// hanantiti321@gmail.com
// Hanantiti321$
      // final role = await FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(userId)
      //     .get()
      //     .then((value) => value.data()!['role'].toString());
      // CacheHelper.saveData(key: "userId", value: userId);
      // //TODO
      // CacheHelper.saveData(key: "role", value: role);

      // await userInfo(value.user!.uid);
      // emit(AppLoginSuccessState(value.user!.uid));
    }).catchError((error) {
      switch (error.code) {
        case "ERROR_EMAIL_ALREADY_IN_USE":
        case "account-exists-with-different-credential":
        case "email-already-in-use":
          error = "Email already used. Go to login page.";
          print(error);
          emit(AppRegisterErrorState(error));
          break;
        case "ERROR_WRONG_PASSWORD":
        case "wrong-password":
          error = "Wrong email/password combination.";
          emit(AppRegisterErrorState(error));
          break;
        case "ERROR_USER_NOT_FOUND":
        case "user-not-found":
          error = "No user found with this email.";
          emit(AppRegisterErrorState(error));
          break;
        case "ERROR_USER_DISABLED":
        case "user-disabled":
          error = "User disabled.";
          emit(AppRegisterErrorState(error));
          break;
        case "ERROR_TOO_MANY_REQUESTS":
        case "operation-not-allowed":
          error = "Too many requests to log into this account.";
          emit(AppRegisterErrorState(error));
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
        case "operation-not-allowed":
          error = "Server error, please try again later.";
          emit(AppRegisterErrorState(error));
          break;
        case "ERROR_INVALID_EMAIL":
        case "invalid-email":
          error = "Email address is invalid.";
          emit(AppRegisterErrorState(error));
          break;
        default:
          error = "Register failed. Please try again.";
          emit(AppRegisterErrorState(error));
          break;
      }
      print(error.toString());
      emit(AppLoginErrorState(error.toString()));
    });
  }

  UserModel? userData;

  Future userInfo(userId) async {
    emit(GetUserDataLoadingState());
    FirebaseFirestore.instance
        .collection("users")
        .doc(userId ?? CacheHelper.getData(key: "userId"))
        .get()
        .then((value) {
      userData = UserModel.fromMap(value.data()!);
      CacheHelper.saveData(key: "username", value: userData!.username);
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetUserDataErrorState(error.toString()));
    });
  }

  Future updateUserInfo(userId, {email, username, password, phone}) async {
    emit(UpdatetUserDataLoadingState());
    FirebaseFirestore.instance.collection("users").doc(userId).update({
      "username": username,
      "email": email,
      "password": password,
      "phone": phone,
    }).then((value) {
      userInfo(userId);
      emit(UpdatetUserDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(UpdatetUserDataErrorState(error.toString()));
    });
  }

  // SignIn With Google
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    emit(SignInWithGoogleLoading());
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    // final credintial = GoogleAuthProvider.credential(
    //   accessToken: googleAuth.accessToken,
    //   idToken: googleAuth.idToken,
    // );
    print(googleUser.email);

///////////////
//databse (firestore cloud)
    FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: googleUser.email)
        .get()
        .then((value) {
      print(value.docs);
      if (value.docs.isNotEmpty) {
        value.docs.forEach((element) {
          if (googleUser.email == element.data()['email']) {
            // print("object");
            userLogin(
                email: element.data()['email'],
                password: element.data()['password']);
          } else {
            emit(SignInWithGoogleFailed("This email address is not existing."));
          }
          print(element.data()['email']);
        });
      } else {
        emit(SignInWithGoogleFailed("This email address is not existing."));
      }
    });
  }
/////////////////////////////////

/////////
  ///Function to reset password////
////////
  Future resetPassword(email) async {
    emit(ResetPasswordLoading());
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .then((value) {
      emit(ResetPasswordSuccessful());
    }).catchError((error) {
      emit(ResetPasswordFailed(error.toString()));
    });
  }
  /////////
  ////////

//Function to Log out from app
  Future signOut(context) async {
    emit(SignoutLoading());
    CacheHelper.removeData(
      key: 'userId',
    ).then((value) async {
      userData = null;
      userId = null;
      CacheHelper.removeData(key: "username");
      FirebaseAuth.instance.signOut();
      showCustomSnackBar(context,
          content: "Signout Successfully",
          bgColor: Colors.green,
          textColor: Colors.white);
      navigateAndFinish(
        context,
        LoginScreen(),
      );
    });

    emit(SignoutSuccessful());
  }
}
