import 'package:adhd_app/localization/app_localizations.dart';
import 'package:adhd_app/provider/general_app_cubit/app_general_cubit.dart';
import 'package:adhd_app/screens/home/home_screen.dart';
import 'package:adhd_app/screens/more/articles_screen.dart';
import 'package:adhd_app/screens/settings/ContactWithusScreen.dart';

import 'package:adhd_app/screens/settings/about_app_screen.dart';
import 'package:adhd_app/screens/settings/term_and_conditions_screen.dart';
import 'package:adhd_app/screens/settings/update_user_info_screen.dart';
import 'package:adhd_app/utiles/colors.dart';
import 'package:adhd_app/utiles/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import '../../utiles/widgets/language_switch.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Settings".tr(context),
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: true,
        elevation: 0.3,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsetsDirectional.only(
            start: 15.0,
            end: 15.0,
            top: 20.0,
            bottom: 20.0,
          ),
          child: Column(
            children: [
              const SwitchLanguage(),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              _itemList(context,
                  icon: FontAwesomeIcons.children,
                  title: "Manage Child Info".tr(context), onPressed: () {
                navigateTo(context, const HomeScreen());
              }),
              _itemList(context,
                  icon: FontAwesomeIcons.edit,
                  title: "Update Info".tr(context), onPressed: () {
                navigateTo(
                    context,
                    UpdateUserInfoScreen(
                      model: AppCubit.get(context).userData!,
                    ));
              }),
            
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(10),
                  color: Theme.of(context).cardColor,
                ),
                child: Column(
                  children: [
                   
                    _itemList(context,
                        icon: FontAwesomeIcons.circleInfo,
                        title: "About Us".tr(context), onPressed: () {
                      navigateTo(
                          context,
                          AboutAppScreen(
                            about: "".tr(context),
                          ));
                    }),
                    _itemList(context,
                        icon: FontAwesomeIcons.contactCard,
                        title: "Contact With US".tr(context), onPressed: () {
                      navigateTo(
                          context,
                          ContactWithUsScreen(
                            about: "Contact With Us".tr(context), terms: 'ADHD_Awareness@gmail.com', 
                          ));
                    }),
                    _itemList(context,
                        icon: FontAwesomeIcons.listCheck,
                        title: "Terms & Conditions".tr(context), onPressed: () {
                      navigateTo(
                          context,
                          ConditionsAndTermsScreen(
                            terms: 'Lorem test.......'.tr(context),
                          ));
                    }),
                  ],
                ),
              ),
              _itemList(context,
                  icon: FontAwesomeIcons.rightFromBracket,
                  title: "Logout".tr(context), onPressed: () {
                AppCubit.get(context).signOut(context);
              }),
              const SizedBox(
                height: 350,
              ),
              Center(
                child: Text(
                  "Version Number: 1.0".tr(context),
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemList(context, {icon, title, onPressed}) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: onPressed,
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.grey,
              size: 20,
            ),
            const SizedBox(
              width: 14,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 17,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.grey,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
