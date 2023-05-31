import 'package:adhd_app/localization/app_localizations.dart';
import 'package:adhd_app/utiles/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:adhd_app/screens/more/articles_screen.dart';

class ArticleScreen1 extends StatelessWidget {
  const ArticleScreen1({Key? key}) : super(key: key);

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
                  'https://www.cdc.gov/ncbddd/adhd/features/images/adhd-awareness_456px.jpg?_=27628'),
              Text(
                "    Behavior Therapy for Children with ADHD".tr(context),
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
                subtitle:  Text(
                    'ADHD is one of the most common enduring conditions of childhood and affects many children, including very young children. Those with more severe symptoms are often diagnosed earlier Being easily distracted, impulsive, and highly active is normal for young children, but when the symptoms are severe and persistent, it can cause problems. Young children with ADHD are more likely than those without ADHD to have difficulties in early education programs or school, including problems with peer relationships, learning, and a higher risk of injuries..'.tr(context),
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
                  'My Young Child has been Diagnosed with ADHD, Now What?'.tr(context),
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 43, 92, 45),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                subtitle: Text(
                  '                                                                                            For older children, the best treatment is often a combination of behavior therapy and medication. But for children under 6 years of age, experts recommend that ADHD be treated with behavior therapy first, before trying medication. Behavior therapy is the recommended treatment for ADHD in children under 6 years of age. The type of behavior therapy that is most effective for this age is parent training in behavior management, meaning that therapists work with parents and teach them the skills needed to help their child better manage their ADHD.'.tr(context),
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
                  'How Can Parent Training in Behavior Management Help my Child?'.tr(context),
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 43, 92, 45),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                subtitle: Text(
                  '                                                                                            Children who have ADHD act in ways that are often challenging for parents. Children may forget things they are told, be overly active, and act before thinking. They might not be able to get positive attention the way that other children can; they tend to misbehave and might be punished more frequently than other children. Even if children with ADHD really try to follow rules, they might not be able to. This can have a negative impact on their self-image, and cause them to give up trying or to act up more often. A therapist skilled in behavior management can help parents understand how ADHD affects their child. Parent training in behavior management is used to help change problem behaviors by building parenting skills, improving the relationship between parents and their child with ADHD, and helping children manage their own behaviors.'.tr(context),
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
                  'Reference'.tr(context),
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 43, 92, 45),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                subtitle: Text(
                  '                                                                                            https://www.cdc.gov/ncbddd/adhd/features/adhd-awareness.html',
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
