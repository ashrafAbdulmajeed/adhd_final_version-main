// ignore_for_file: prefer_const_constructors

import 'package:adhd_app/admin_panel/article_panel/articles_control.dart';
import 'package:adhd_app/admin_panel/questionnaiers_control.dart';
import 'package:adhd_app/admin_panel/users_panel/users_control.dart';
import 'package:adhd_app/screens/home/home_screen.dart';
import 'package:adhd_app/screens/specialists/specialists_screen.dart';
import 'package:adhd_app/utiles/colors.dart';
import 'package:adhd_app/utiles/components.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Admin Panel'),
          actions: [
            InkWell(
              onTap: () {
                navigateTo(context, const HomeScreen());
                // Navigator.of(context).push(route);
              },
              child: RawChip(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                label: Text(
                  'Home',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: AppColors.mainColor),
                ),
                avatar: Icon(
                  FontAwesomeIcons.house,
                  color: AppColors.mainColor,
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        drawer: InkWell(
          onTap: () async {
            // FirebaseAuth.
          },
          child: Drawer(
            backgroundColor: Colors.grey[300],
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                    currentAccountPicture: CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 143, 244, 236),
                        child: Text('')),
                    accountName: Text('ADHD Admin'),
                    accountEmail: Text('ADHD_Awareness@gmail.com')),
                ListTile(
                  title: Text('Users'),
                  leading: Icon(Icons.verified_user_sharp),
                  onTap: () {
                    navigateTo(context, UsersControl());
                  },
                ),
                //
                SizedBox(
                  height: 10,
                ),
                //
                ListTile(
                  title: Text('Questionnaires'),
                  leading: Icon(Icons.question_mark_sharp),
                  onTap: () {
                    navigateTo(context, QuestionnairesControl());
                  },
                ),
                //
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: Text('Articles'),
                  leading: Icon(Icons.insert_drive_file_outlined),
                  onTap: () {
                    navigateTo(context, ArticlesControl());
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                //
                ListTile(
                  title: Text('Doctors info'),
                  leading: Icon(Icons.contact_emergency),
                  onTap: () {
                    navigateTo(
                      context,
                      SpecialistsScreen(
                        isAdmin: true,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 120.0, left: 20, right: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: AdminBox(
                      onTap: () {
                        navigateTo(context, UsersControl());
                      },
                      title: 'Users',
                      icon: FontAwesomeIcons.userGear,
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Expanded(
                    child: AdminBox(
                      onTap: () {
                        navigateTo(context, QuestionnairesControl());
                      },
                      title: 'Questionnaires',
                      icon: FontAwesomeIcons.clipboardQuestion,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 90,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: AdminBox(
                      onTap: () {
                        navigateTo(context, ArticlesControl());
                      },
                      title: 'Articles',
                      icon: FontAwesomeIcons.newspaper,
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Expanded(
                    child: AdminBox(
                      onTap: () {
                        navigateTo(
                          context,
                          SpecialistsScreen(isAdmin: true),
                        );
                      },
                      title: 'Doctorss info',
                      icon: FontAwesomeIcons.userDoctor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

class AdminBox extends StatelessWidget {
  const AdminBox({Key? key, this.icon, required this.title, this.onTap})
      : super(key: key);
  final IconData? icon;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.mainColor.withOpacity(0.4),
              // color: Colors.teal.shade200,
              blurRadius: 5,
              spreadRadius: 0.5,
              // blurStyle: BlurStyle.outer,
              offset: Offset(6, 6),
            ),
            BoxShadow(
              color: Colors.white30,
              // color: Colors.teal.shade200,
              blurRadius: 5,
              spreadRadius: 0.5,
              // blurStyle: BlurStyle.outer,
              offset: Offset(-2, -2),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Colors.grey.shade50],
            ),
          ),
          alignment: Alignment.center,
          height: size.height * 0.25,
          width: size.width * 0.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 50,
              ),
              SizedBox(height: 25),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              )
            ],
          ),
        ),
      ),
    );
  }
}
