// ignore_for_file: unused_import, depend_on_referenced_packages, duplicate_import, avoid_unnecessary_containers

import 'package:adhd_app/admin_panel/admin.dart';
import 'package:adhd_app/localization/app_localizations.dart';
import 'package:adhd_app/models/child_info.dart';
import 'package:adhd_app/models/doctor_model.dart';
import 'package:adhd_app/models/user_model.dart';
import 'package:adhd_app/provider/general_app_cubit/app_general_cubit.dart';
import 'package:adhd_app/provider/general_app_cubit/states.dart';
import 'package:adhd_app/screens/child_info/child_info_screen.dart';
import 'package:adhd_app/screens/child_info/update_child_info_screen.dart';
import 'package:adhd_app/screens/home/Anx1_card.dart';
import 'package:adhd_app/screens/home/Anx2._card.dart';
import 'package:adhd_app/screens/home/My_card.dart';
import 'package:adhd_app/screens/home/My_card2.dart';
import 'package:adhd_app/screens/home/My_card3.dart';
import 'package:adhd_app/screens/home/adhd.dart';
import 'package:adhd_app/screens/home/adhd.dart';
import 'package:adhd_app/screens/questionaire/questions_screen.dart';
import 'package:adhd_app/screens/settings/settings_screen.dart';
import 'package:adhd_app/screens/settings/update_user_info_screen.dart';
import 'package:adhd_app/screens/specialists/specialists_screen.dart';
import 'package:adhd_app/utiles/app_constants.dart';
import 'package:adhd_app/utiles/colors.dart';
import 'package:adhd_app/utiles/components.dart';
import 'package:adhd_app/utiles/network/local/cache_helper.dart';
import 'package:adhd_app/utiles/widgets/app_column.dart';
import 'package:adhd_app/utiles/widgets/intro_questionnaire_screen.dart';
import 'package:adhd_app/utiles/widgets/language_switch.dart';
import 'package:adhd_app/utiles/widgets/stateful_wraper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../utiles/my_functions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //page controller
  final _controller = PageController();
  final _controller1 = PageController();
  List<Widget> listOptions = <Widget>[
    const ChildInfoScreen(),
    //IntroQuestionnaireScreen()
  ];
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentPageValue = 0.0;
  var _scaleFactor = 0.8;
  List<Doctor>? doctors;
  UserModel? user;

  @override
  void initState() {
    super.initState();
    user = AppCubit.get(context).userData;
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
        print("Current val is: " + _currentPageValue.toString());
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(listener: ((context, state) {
      if (state is RemoveChildSuccessState) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Child Removed Successfully!".tr(context)),
          backgroundColor: Colors.green,
        ));
      }
    }), builder: (context, state) {
      AppCubit appCubit = AppCubit.get(context);

      return StatefulWrapper(
        //if the screen loading bring user info + child info
        onInit: () {
          AppCubit.get(context)
              .userInfo(CacheHelper.getData(key: 'userId'))
              .then((value) {
            AppCubit.get(context).getChildrenInfo();
          });
        },
        child: Directionality(
          textDirection:
              checkLocalIsEn(context) ? TextDirection.ltr : TextDirection.rtl,
          child: Scaffold(
            body: ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                _topBar(),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.child_care,
                              color: Colors.black,
                              size: 27,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              "Your Children Info".tr(context),
                              style: GoogleFonts.lato(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      ConditionalBuilder(
                        condition: state is! GetChildrenLoadingState,
                        builder: (context) => ConditionalBuilder(
                            condition: appCubit.children.isNotEmpty,
                            builder: (context) => Container(
                                  height: 300,
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    itemCount: appCubit.children.length,
                                    itemBuilder: ((context, index) {
                                      return childInfoBuilder(
                                          appCubit.children[index]);
                                    }),
                                    separatorBuilder: ((context, index) {
                                      return const SizedBox(
                                        height: 1,
                                      );
                                    }),
                                  ),
                                ),
                            fallback: (context) => const EmptyBoxWidget()),
                        fallback: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //button to add child
                      const SizedBox(
                        height: 30,
                      ),

                      Container(
                        height: 206,
                        child: PageView(
                          scrollDirection: Axis.horizontal,
                          controller: _controller,
                          children: [
                            const MyCard1(),
                            const MyCard3(),
                            const AnxCard1(),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SmoothPageIndicator(
                        controller: _controller,
                        count: 3,
                        effect: ExpandingDotsEffect(
                            activeDotColor: Colors.grey.shade700,
                            dotWidth: 10,
                            dotHeight: 10),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

/////
  // Top bar

  Widget _topBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              navigateTo(context, SettingsScreen());
            },
            child: Container(
              padding: const EdgeInsets.all(3.5),
              height: 60,
              width: 60,
              child: const CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                      'https://gravatar.com/avatar/cab04dccc1b4ddeedd2d51d133e31a6f?s=400&d=robohash&r=x')),
            ),
          ),
          InkWell(
            onTap: () {
              navigateTo(context, SettingsScreen());
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello'.tr(context),
                    style: const TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '@${CacheHelper.getData(key: 'username') ?? "guest".tr(context)}',
                        style: TextStyle(
                          fontSize: 17,
                          color: AppColors.mainColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColors.mainColor,
                        size: 15,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          CacheHelper.getData(key: 'role') != null &&
                  CacheHelper.getData(key: 'role') == 'admin'
              ? InkWell(
                  onTap: () {
                    navigateTo(context, const AdminScreen());
                    // Navigator.of(context).push(route);
                  },
                  child: RawChip(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    label: Text(
                      'Admin',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: AppColors.mainColor),
                    ),
                    avatar: Icon(
                      FontAwesomeIcons.userPen,
                      color: AppColors.mainColor,
                    ),
                  ),
                )
              : const SizedBox(),
          const SizedBox(
            width: 10,
          ),
          IconButton(
              onPressed: () {
                AppCubit.get(context).signOut(context);
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
    );
  }
  /////
  // Top bar

//////////
  ///child box
  ///
  Widget childInfoBuilder(ChildModel model) {
    return InkWell(
      onTap: () {
        navigateTo(
          context,
          IntroQuestionnaireScreen(
            childID: model.id!,
            isChild: model.isChild!,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: const BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            offset: Offset(0, 3),
            color: Color.fromARGB(155, 201, 201, 201),
            blurRadius: 5.0,
          ),
        ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CircleAvatar(backgroundColor: Colors.grey),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name!,
                  style: GoogleFonts.lato(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  "${model.gender?.tr(context)} - ${model.age.toString()} YR . ",
                  style: GoogleFonts.lato(fontSize: 15, color: Colors.grey),
                ),
                if (model.adhdResult != '')
                  Container(
                    width: 150,
                    child: Text(
                      "${'ADHD'.tr(context)}: ${checkStringLang(
                        ar: model.adhdResultAr.toString(),
                        context: context,
                        en: model.adhdResult.toString(),
                      )}",
                      style: GoogleFonts.lato(fontSize: 15, color: Colors.grey),
                    ),
                  ),
                if (model.levelResult != '')
                  Container(
                    width: 150,
                    child: Text(
                      "${'LEVEL'.tr(context)}: ${checkStringLang(
                        ar: model.levelResultAr.toString(),
                        context: context,
                        en: model.levelResult.toString(),
                      )}",
                      style: GoogleFonts.lato(fontSize: 15, color: Colors.grey),
                    ),
                  ),
              ],
            ),
//////////
            ///child box
            ///

            /////////////////Edit child and delete
            ///
            const Spacer(),
            IconButton(
                onPressed: () {
                  navigateTo(
                      context,
                      UpdateChildInfoScreen(
                        model: model,
                      ));
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.green,
                )),
            IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .removeChildInfo(id: model.id.toString());
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ))
          ],
        ),
      ),
    );
  }
}
/////////////////Edit child and delete
///

///////////////////////////////
///Empty Box
//////////////////////////////
class EmptyBoxWidget extends StatelessWidget {
  const EmptyBoxWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LottieBuilder.asset(Resources.emptyBox,
                height: MediaQuery.of(context).size.height * 0.2),
            const SizedBox(height: 20),
            Text("Sorry not found any children".tr(context),
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  fontFamily: "Cairo",
                )),
          ],
        ),
      ),
    );
  }
}
///////////////////////////////
///Empty Box
//////////////////////////////
