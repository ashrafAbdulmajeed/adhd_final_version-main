import 'package:adhd_app/admin_panel/article_panel/add_article_screen.dart';
import 'package:adhd_app/admin_panel/article_panel/update_article_screen.dart';
import 'package:adhd_app/admin_panel/widgets/admin_functions.dart';
import 'package:adhd_app/models/article.dart';
import 'package:adhd_app/screens/specialists/specialist_details_screen.dart';
import 'package:adhd_app/utiles/colors.dart';
import 'package:adhd_app/utiles/components.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ArticlesControl extends StatefulWidget {
  const ArticlesControl({super.key});

  @override
  State<ArticlesControl> createState() => _ArticlesControlState();
}

class _ArticlesControlState extends State<ArticlesControl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mainColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddArticleScreen(),
            ),
          );
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Articles control',
          textAlign: TextAlign.center,
        ),
        // backgroundColor: Colors.grey[300],
      ),
      body: StreamBuilder<List<MainArticleModel>>(
        // stream: getAllUsers(),
        stream: UsersOperations.getAllMainArticles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LayoutBuilder(builder: (context, constraint) {
                    return InkWell(
                      onTap: () {
                        AwesomeDialog(
                          dialogBackgroundColor: Colors.white,
                          btnCancelIcon: FontAwesomeIcons.drumSteelpan,
                          btnCancelOnPress: () {
                            UsersOperations.deleteArticle(
                                articleId:
                                    snapshot.data![i].articleId.toString(),
                                context: context);
                          },
                          btnCancelText: " Delete",
                          customHeader: CircleAvatar(
                            radius: 45,
                            onForegroundImageError: (exception, stackTrace) =>
                                const Icon(
                              Icons.person,
                              size: 40,
                            ),
                            foregroundImage: NetworkImage(
                              snapshot.data![i].imageUrl.toString(),
                            ),
                          ),
                          btnCancelColor: Colors.red,
                          btnOkIcon: FontAwesomeIcons.expeditedssl,
                          btnOkColor: AppColors.mainColor,
                          btnOkText: " Update",
                          buttonsTextStyle: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Colors.white, fontSize: 14),
                          btnOkOnPress: () {
                            navigateTo(
                              context,
                              UpdateArticleScreen(
                                mainArticleModel: snapshot.data![i],
                              ),
                            );
                          },
                          context: context,
                          body: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                infoCardBuilder(
                                  title: "Title",
                                  subTitle: snapshot.data![i].title,
                                  icon: FontAwesomeIcons.penClip,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ).show();
                      },
                      child: Card(
                          color: Colors.white,
                          surfaceTintColor: Colors.white,
                          shadowColor: AppColors.mainColor,
                          elevation: 7,
                          child: Column(
                            children: [
                              PostWidget(
                                imageUrl: snapshot.data![i].imageUrl.toString(),
                                title: snapshot.data![i].title.toString(),
                                subtitle: snapshot.data![i].subtitle ?? "",
                              ),
                            ],
                          )),
                    );
                  }),
                );
              },
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

class PostWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;

  const PostWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 5),
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              imageUrl,
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.width * 0.3,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.group,
                size: 100,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
