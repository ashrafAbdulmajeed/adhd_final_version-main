import 'package:adhd_app/localization/app_localizations.dart';
import 'package:adhd_app/utiles/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:adhd_app/screens/more/articles_screen.dart';

class ArticleScreen2 extends StatelessWidget {
  const ArticleScreen2({Key? key}) : super(key: key);

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
          "Article".tr(context),
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                  'https://adhd.org.sa/wp-content/uploads/2021/11/5012736316_76251d1954_o-2.jpg'),
              Text(
                "Benefits of physical exercise".tr(context),
                style: GoogleFonts.cairo(
                  textStyle: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 15,
              ),
              const Divider(
                height: 17,
                thickness: 2,
                indent: 80,
                endIndent: 80,
                color: Colors.black,
              ),
              const SizedBox(
                height: 15,
              ),
              ListTile(
                title: Text(
                    'General health improvement and ability to care for one’s self'
                        .tr(context),
                    style: TextStyle(fontSize: 16)),
                tileColor: Colors.grey[100],
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.white)),
              ),
              const SizedBox(
                height: 40,
              ),
              ListTile(
                tileColor: Color.fromARGB(60, 232, 230, 230),
                title: Text(
                  'Reduce anxiety as well as insomnia and stress reduction'
                      .tr(context),
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 43, 92, 45),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                // subtitle: Text(
                //   'Increased strength and muscular endurance'.tr(context),
                //   style: TextStyle(fontSize: 16),
                //   textAlign: TextAlign.center,
                // ),
              ),
              const SizedBox(
                height: 40,
              ),
              ListTile(
                tileColor: Color.fromARGB(60, 232, 230, 230),
                title: Text(
                  'Increased strength and muscular endurance'.tr(context),
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ListTile(
                tileColor: Color.fromARGB(60, 232, 230, 230),
                title: Text(
                  'Aids relaxation'.tr(context),
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 43, 92, 45),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ListTile(
                tileColor: Color.fromARGB(60, 232, 230, 230),
                title: Text(
                  'Reference'.tr(context),
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 43, 92, 45),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                subtitle: Text(
                  '                                                                                            https://adhd.org.sa/en/2021/11/08/benefits-of-physical-exercise/',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
