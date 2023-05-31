import 'package:adhd_app/localization/app_localizations.dart';
import 'package:adhd_app/models/doctor_model.dart';
import 'package:adhd_app/utiles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class SpecialistDetailsScreen extends StatelessWidget {
  Doctor doctor;
   SpecialistDetailsScreen({Key? key, required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQ = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.4,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: Text(
          "Specialist Details".tr(context),
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              color: Colors.black87,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsetsDirectional.only(
            top: 20,
            start: 10,
            end: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('assets/images/${doctor.image}.png'),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                doctor.name!,
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
               const SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  doctor.job!,
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              infoCardBuilder(
                  title: "Address".tr(context),
                  subTitle: doctor.address,
                  icon: FontAwesomeIcons.addressCard),
              const SizedBox(
                height: 10,
              ),
              infoCardBuilder(
                  title: "Phone Number".tr(context),
                  subTitle: doctor.phone,
                  icon: FontAwesomeIcons.whatsapp,
                  iconSize: 20.0),
              const SizedBox(
                height: 10,
              ),
              infoCardBuilder(
                  title: "Email".tr(context),
                  subTitle: doctor.email,
                  icon: FontAwesomeIcons.envelope,
                  iconSize: 20.0),
              const SizedBox(
                height: 20,
              ),
            
             
            ],
          ),
        ),
      ),
    );
  }

  
}

Widget infoCardBuilder({title, subTitle, icon, iconSize}) {
  return Container(
    width: double.infinity,
    padding:
        const EdgeInsetsDirectional.only(start: 15, end: 10, top: 15, bottom: 15),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusDirectional.circular(10),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 0),
            color: Color.fromARGB(122, 192, 192, 192),
            blurRadius: 7.0,
          ),
        ]),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: AppColors.mainColorSha2,
              size: iconSize ?? 17,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                    color: AppColors.mainColor,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          subTitle,
          style: GoogleFonts.lato(
            textStyle: const TextStyle(color: Colors.black87, fontSize: 15),
          ),
        ),
      ],
    ),
  );
}
