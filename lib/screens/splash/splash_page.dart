import 'dart:async';

import 'package:adhd_app/screens/home/home_screen.dart';
import 'package:adhd_app/utiles/components.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    Timer(
      const Duration(seconds: 2),
      () => navigateAndFinish(
          context,
          //TODO if the user is admin return admin else return home
          // ArticlesScreen(),
          // const AdminScreen()
          const HomeScreen()
          // ArticlesScreen() //TODO
          // HomeScreen(),
          ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
              scale: animation,
              child: Center(
                  child: Image.asset(
                "assets/images/splash.png",
                width: double.maxFinite,
              ))),
        ],
      ),
    );
  }
}
