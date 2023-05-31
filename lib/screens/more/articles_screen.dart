import 'package:adhd_app/localization/app_localizations.dart';
import 'package:adhd_app/models/article.dart';
import 'package:adhd_app/screens/more/article_screen.dart';
import 'package:adhd_app/utiles/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

///Done & Clean
class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({Key? key}) : super(key: key);

  @override
  _ArticlesScreenState createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.8),
        elevation: 0.4,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          "Articles".tr(context),
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: FutureBuilder<List<MainArticleModel>>(
          future: getAllMainArticlesFromFirestore(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  final MainArticleModel data = snapshot.data![index];
                  // articles[index];
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: Colors.white.withOpacity(0.8),
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network(
                                // snapshot.data![index].imageUrl.toString(),
                                data.imageUrl.toString(),
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(
                                  Icons.group,
                                  size: 95,
                                ),
                                height: 200,
                                width: 400,
                              ),
                              ListTile(
                                onTap: () {
                                  navigateTo(
                                    context,
                                    // article.screen
                                    ArticleScreen(
                                        articleDetails: data.articleModel),
                                  );
                                },
                                tileColor: Colors.white,
                                title: Text(
                                  data.title.toString(),
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                subtitle: Text(
                                  data.subtitle.toString(),
                                  // .tr(context),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                                shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.purple,
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Error in server"),
              );
            } else {
              return const SizedBox();
            }
          }),
    );
  }
}

Future<List<MainArticleModel>> getAllMainArticlesFromFirestore() async {
  final firestoreInstance = FirebaseFirestore.instance;
  final mainArticlesQuerySnapshot =
      await firestoreInstance.collection("MainArticle").get();
  final mainArticles = <MainArticleModel>[];
  for (final mainArticleSnapshot in mainArticlesQuerySnapshot.docs) {
    if (mainArticleSnapshot.exists) {
      final mainArticleData = mainArticleSnapshot.data()!;
      MainArticleModel mainArticle = MainArticleModel.fromJson(mainArticleData);
      mainArticles.add(mainArticle);
    }
  }
  return mainArticles;
}

Stream<List<MainArticleModel>> getAllMainArticles() {
  final firestoreInstance = FirebaseFirestore.instance;
  final mainArticlesStream =
      firestoreInstance.collection("MainArticle").snapshots();
  return mainArticlesStream.map((querySnapshot) {
    final mainArticles = <MainArticleModel>[];
    for (final mainArticleSnapshot in querySnapshot.docs) {
      if (mainArticleSnapshot.exists) {
        final mainArticleData = mainArticleSnapshot.data()!;
        MainArticleModel mainArticle =
            MainArticleModel.fromJson(mainArticleData);
        mainArticles.add(mainArticle);
      }
    }
    return mainArticles;
  });
}
