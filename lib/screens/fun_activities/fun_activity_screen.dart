import 'package:adhd_app/localization/app_localizations.dart';
import 'package:adhd_app/screens/fun_activities/xo_game/main_screen.dart';
import 'package:adhd_app/screens/home/home_screen.dart';
import 'package:adhd_app/utiles/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class FunActivity extends StatelessWidget {
  const FunActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQ = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.4,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                navigateTo(context, HomeScreen());
              },
              icon: Icon(
                Icons.home,
                color: Color.fromARGB(255, 96, 94, 94),
                size: 30,
              ))
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: Text(
          "Fun Activities".tr(context),
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              color: Colors.black87,
            ),
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          itemActivity(context),
        ],
      ),
    );
  }

  Widget itemActivity(context) {
    return Container(
      // height: 300,
      margin: const EdgeInsetsDirectional.only(
        top: 20,
        bottom: 20,
        start: 10,
        end: 10,
      ),
      decoration: BoxDecoration(
        color: Color.fromARGB(132, 255, 193, 7),
        borderRadius: BorderRadiusDirectional.circular(20),
        image: const DecorationImage(
            image: AssetImage(
              "assets/images/xo-game.jpg",
            ),
            fit: BoxFit.cover),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              "XO Game".tr(context),
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          // Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsetsDirectional.only(
                top: 20,
                bottom: 20,
                start: 10,
                end: 10,
              ),
              decoration: const BoxDecoration(
                  color: Color.fromARGB(111, 217, 217, 217),
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(20),
                    topEnd: Radius.circular(20),
                    bottomEnd: Radius.circular(20),
                    bottomStart: Radius.circular(20),
                  )),
              child: filledButtonV2(
                  title: "Play Now".tr(context),
                  radius: 10.0,
                  onPressed: () {
                    navigateTo(context, XOGameScreen());
                  }),
            ),
          )
        ],
      ),
    );
  }
}
