import 'package:adhd_app/localization/app_localizations.dart';
import 'package:adhd_app/models/article.dart';
import 'package:adhd_app/utiles/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ArticleScreen extends StatelessWidget {
  final ArticleModel? articleDetails;

  const ArticleScreen({Key? key, this.articleDetails}) : super(key: key);

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
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          articleDetails!.title.toString(),
          style: GoogleFonts.cairo(
            textStyle: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image
              Image.network(
                articleDetails!.imageUrl.toString(),
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.group,
                  size: 150,
                ),
              ),
              // Title
              Text(
                articleDetails!.title.toString(),
                style: GoogleFonts.cairo(
                  textStyle: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
              // Author
              SmallText(text: articleDetails!.author.toString()),
              const SizedBox(height: 15),
              // Subtitle
              Text(
                articleDetails!.subTitle.toString(),
                style: GoogleFonts.cairo(
                  textStyle: const TextStyle(
                    color: Colors.black87,
                    fontSize: 19,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Divider(
                height: 17,
                thickness: 2,
                indent: 80,
                endIndent: 80,
                color: Colors.black,
              ),
              const SizedBox(height: 15),
              if (articleDetails!.tips != null)
                ...List.generate(
                    articleDetails!.tips!.length,
                    (index) => ListTile(
                          tileColor: const Color.fromARGB(60, 232, 230, 230),
                          title: Text(
                            articleDetails!.tips![index].title.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 43, 92, 45),
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          subtitle: Text(
                            articleDetails!.tips![index].description.toString(),
                            style: const TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        )),

              // Tips
              // if(article.tips!=null)

              const SizedBox(height: 40),
              // References
              ListTile(
                tileColor: const Color.fromARGB(60, 232, 230, 230),
                title: Text(
                  'References'.tr(context),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 43, 92, 45),
                  ),
                  textAlign: TextAlign.center,
                ),
                subtitle: Text(
                  articleDetails!.references.toString(),
                  style: const TextStyle(fontSize: 14),
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
// class ArticleScreen extends StatelessWidget {
//   final ArticleModel article;

//   const ArticleScreen({Key? key, required this.article}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0.4,
//         centerTitle: true,
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: const Icon(Icons.arrow_back_ios)),
//         title: Text(
//           article.title,
//           style: GoogleFonts.cairo(
//             textStyle: const TextStyle(
//                 color: Colors.black87,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 20),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         child: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               //image
//               Image.network(article.imageUrl),
//               //titles
//               Text(
//                 article.title,
//                 style: GoogleFonts.cairo(
//                   textStyle: const TextStyle(
//                       color: Colors.black87,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 30),
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               //auther
//               SmallText(
//                 text: 'By ${article.author}',
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               // subTitle
//               Text(
//                 article.subtitle,
//                 style: GoogleFonts.cairo(
//                   textStyle:
//                       const TextStyle(color: Colors.black87, fontSize: 19),
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               const Divider(
//                 height: 17,
//                 thickness: 2,
//                 indent: 80,
//                 endIndent: 80,
//                 color: Colors.black,
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               // Tips
//               Column(
//                 children: article.tips.map((tip) {
//                   return ListTile(
//                     tileColor: const Color.fromARGB(60, 232, 230, 230),
//                     title: Text(
//                       tip,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         color: Color.fromARGB(255, 43, 92, 45),
//                         fontWeight: FontWeight.bold,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   );
//                 }).toList(),
//               ),
//               const SizedBox(
//                 height: 40,
//               ),
//               ListTile(
//                 tileColor: const Color.fromARGB(60, 232, 230, 230),
//                 title: Text(
//                   'References',
//                   style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Color.fromARGB(255, 43, 92, 45)),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               // References
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Text(
//                   article.references,
//                   style: GoogleFonts.cairo(
//                     textStyle: const TextStyle(
//                       fontSize: 16,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 40,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ArticleScreen extends StatelessWidget {
//   const ArticleScreen({Key? key}) : super(key: key);

// // final ArticleModel
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0.4,
//         centerTitle: true,
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: const Icon(Icons.arrow_back_ios)),
//         title: Text(
//           "Article".tr(context),
//           style: GoogleFonts.cairo(
//             textStyle: const TextStyle(
//                 color: Colors.black87,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 20),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         child: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               //image
//               Image.network(
//                   'https://i.pinimg.com/564x/82/79/e6/8279e6d1586d0a702a49dffcc74a1702.jpg'),
//             //titles
//               Text(
//                 "      ADHD Parenting Tips".tr(context),
//                 style: GoogleFonts.cairo(
//                   textStyle: const TextStyle(
//                       color: Colors.black87,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 30),
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             //auther
//               SmallText(
//                 text:
//                     'By Melinda Smith, M.A. and Jeanne Segal, Ph.D.'
//                         .tr(context),
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               // subTitle
//               Text(
//                 "         How to help your child with ADHD!".tr(context),
//                 style: GoogleFonts.cairo(
//                   textStyle:
//                       const TextStyle(color: Colors.black87, fontSize: 19),
//                 ),
//               ),
//               // Divider(height: 30, thickness: 0.6, color: Colors.grey),
//               // const SizedBox(
//               //   heigh
//               //t: 15,
//               // ),
//               const SizedBox(
//                 height: 10,
//               ),
//               const Divider(
//                 height: 17,
//                 thickness: 2,
//                 indent: 80,
//                 endIndent: 80,
//                 color: Colors.black,
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               ListTile(
//                 subtitle: Text(
//                     'Life with a child or teen with attention deficit hyperactivity disorder can be frustrating, even overwhelming. But as a parent you can help your child overcome daily challenges, channel their energy into positive arenas, and bring greater calm to your family. And the earlier and more consistently you address your child’s problems, the greater chance they have for success in life.If you keep in mind that having ADHD is just as frustrating for your child, it will be a lot easier to respond in positive, supportive ways. With patience, compassion, and plenty of support, you can manage childhood ADHD while enjoying a stable, happy home.'
//                         .tr(context),
//                     style: const TextStyle(fontSize: 16)),
//                 tileColor: Colors.grey[100],
//                 shape: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                     borderSide: const BorderSide(color: Colors.white)),
//               ),
//               const SizedBox(
//                 height: 40,
//               ),
//               ListTile(
//                 tileColor: const Color.fromARGB(60, 232, 230, 230),
//                 title: Text(
//                   'Tip 1: Stay positive and healthy yourself'.tr(context),
//                   style: const TextStyle(
//                     fontSize: 16,
//                     color: Color.fromARGB(255, 43, 92, 45),
//                     fontWeight: FontWeight.bold,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 subtitle: Text(
//                   '                                                                                            As a parent, you set the stage for your child emotional and physical health. You have control over many of the factors that can positively influence the symptoms of your child disorder.'
//                       .tr(context),
//                   style: const TextStyle(fontSize: 16),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               const SizedBox(
//                 height: 40,
//               ),
//               ListTile(
//                 tileColor: const Color.fromARGB(60, 232, 230, 230),
//                 title: Text(
//                   'Tip 2: Establish structure and stick to it'.tr(context),
//                   style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Color.fromARGB(255, 43, 92, 45)),
//                   textAlign: TextAlign.center,
//                 ),
//                 subtitle: Text(
//                   '                                                                                            Children with ADHD are more likely to succeed in completing tasks when the tasks occur in predictable patterns and in predictable places. Your job is to create and sustain structure in your home, so that your child knows what to expect and what they are expected to do.'
//                       .tr(context),
//                   style: const TextStyle(fontSize: 16),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               const SizedBox(
//                 height: 40,
//               ),
//               ListTile(
//                 tileColor: const Color.fromARGB(60, 232, 230, 230),
//                 title: Text(
//                   'Tip 3: Encourage movement and sleep'.tr(context),
//                   style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Color.fromARGB(255, 43, 92, 45)),
//                   textAlign: TextAlign.center,
//                 ),
//                 subtitle: Text(
//                   '                                                                                            Children with ADHD often have energy to burn. Organized sports and other physical activities can help them get their energy out in healthy ways and focus their attention on specific movements and skills. The benefits of physical activity are endless: it improves concentration, decreases depression and anxiety, and promotes brain growth. Most importantly for children with attention deficits, however, is the fact that exercise leads to better sleep, which in turn can also reduce the symptoms of ADHD'
//                       .tr(context),
//                   style: const TextStyle(fontSize: 16),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               const SizedBox(
//                 height: 40,
//               ),
//               ListTile(
//                 tileColor: const Color.fromARGB(60, 232, 230, 230),
//                 title: Text(
//                   'Tip 4: Set clear expectations and rules'.tr(context),
//                   style: const TextStyle(
//                     fontSize: 16,
//                     color: Color.fromARGB(255, 43, 92, 45),
//                     fontWeight: FontWeight.bold,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 subtitle: Text(
//                   '                                                                                            Children with ADHD need consistent rules that they can understand and follow. Make the rules of behavior for the family simple and clear. Write down the rules and hang them up in a place where your child can easily read them. Children with ADHD respond particularly well to organized systems of rewards and consequences. Its important to explain what will happen when the rules are obeyed and when they are broken. Finally, stick to your system: follow through each and every time with a reward or a consequence.'
//                       .tr(context),
//                   style: const TextStyle(fontSize: 16),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               const SizedBox(
//                 height: 40,
//               ),
//               ListTile(
//                 tileColor: const Color.fromARGB(60, 232, 230, 230),
//                 title: Text(
//                   'Tip 5: Help your child eat right'.tr(context),
//                   style: const TextStyle(
//                     fontSize: 16,
//                     color: Color.fromARGB(255, 43, 92, 45),
//                     fontWeight: FontWeight.bold,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 subtitle: Text(
//                   '                                                                                            Diet is not a direct cause of attention deficit disorder, but food can and does affect your child mental state, which in turn seems to affect behavior. Monitoring and modifying what, when, and how much your child eats can help decrease the symptoms of ADHD'
//                       .tr(context),
//                   style: const TextStyle(fontSize: 16),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               const SizedBox(
//                 height: 40,
//               ),
//               ListTile(
//                 tileColor: const Color.fromARGB(60, 232, 230, 230),
//                 title: Text(
//                   'Tip 6: Teach your child how to make friends'.tr(context),
//                   style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Color.fromARGB(255, 43, 92, 45)),
//                   textAlign: TextAlign.center,
//                 ),
//                 subtitle: Text(
//                   '                                                                                            Children with ADHD often have difficulty with simple social interactions. They may struggle with reading social cues, talk too much, interrupt frequently, or come off as aggressive or “too intense.” Their relative emotional immaturity can make them stand out among children their own age, and make them targets for unfriendly teasing. Dont forget, though, that many kids with ADHD are exceptionally intelligent and creative and will eventually figure out for themselves how to get along with others and spot people who are not appropriate as friends. Moreover, personality traits that might exasperate parents and teachers may come across to peers as funny and charming.'
//                       .tr(context),
//                   style: const TextStyle(fontSize: 16),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               const SizedBox(
//                 height: 40,
//               ),
//               ListTile(
//                 tileColor: const Color.fromARGB(60, 232, 230, 230),
//                 title: Text(
//                   'References'.tr(context),
//                   style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Color.fromARGB(255, 43, 92, 45)),
//                   textAlign: TextAlign.center,
//                 ),
//                 subtitle: const Text(
//                   '                                                                                            1. Neurodevelopmental Disorders. (2013). In Diagnostic and Statistical Manual of Mental Disorders. American Psychiatric Association.                                                                                                                      2. Ciesielski, H. A., Loren, R. E. A., & Tamm, L. (2020). Behavioral Parent Training for ADHD Reduces Situational Severity of Child Noncompliance and Related Parental Stress. Journal of Attention Disorders, 24(5), 758–767..                                                                                                                                                            3. Harpin, V. A. (2005). The effect of ADHD on the life of an individual, their family, and community from preschool to adult life. Archives of Disease in Childhood, (suppl 1), i2–i7.',
//                   style: TextStyle(fontSize: 14),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
