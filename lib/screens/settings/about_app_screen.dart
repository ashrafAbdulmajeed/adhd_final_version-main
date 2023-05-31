import 'package:adhd_app/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutAppScreen extends StatelessWidget {
  final String about;
  const AboutAppScreen({Key? key, required this.about}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.4,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: Text(
          "About Us".tr(context),
          style: GoogleFonts.cairo(
            textStyle: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                "welcome to our application ! we help the parent to identify if their children or teenagers have ADHD or NOT , also we predict the anxiety level for their teenagers. For children , there is a fun game and the parent can contact with specialists in ADHD as well as reading some useful articles to increase their knowldege.For teenagers , also the parent can contact with specialists ."
                    .tr(context),
                style: GoogleFonts.cairo(
                  textStyle: TextStyle(
                      color: Colors.black87,
                      //fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                about,
                style: GoogleFonts.cairo(
                  textStyle:
                      const TextStyle(color: Colors.black87, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
