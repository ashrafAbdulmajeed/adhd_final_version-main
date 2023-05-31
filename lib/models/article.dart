class ArticleModel {
  final String? articleId; //لايظهر
  final String? imageUrl;
  final String? title;
  final String? titleAr;
  final String? author;
  final String? authorAr;
  final String? subTitle;
  final String? subTitleAr;
  final List<TipModel>? tips;
  final String? references;
  final String? referencesAr;

  ArticleModel({
    this.referencesAr,
    this.titleAr,
    this.authorAr,
    this.subTitleAr,
    this.articleId,
    this.imageUrl,
    this.title,
    this.author,
    this.subTitle,
    this.tips,
    this.references,
  });

  @override
  String toString() {
    return 'ArticleModel{articleId: $articleId, imageUrl: $imageUrl, title: $title, titleAr: $titleAr, author: $author, authorAr: $authorAr, subTitle: $subTitle, subTitleAr: $subTitleAr, tips: $tips, references: $references, referencesAr: $referencesAr}';
  }

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> tipsJson = json['tips'] ?? [];
    List<TipModel> tipsList =
        tipsJson.map((tip) => TipModel.fromJson(tip)).toList();

    return ArticleModel(
      articleId: json['articleId'],
      imageUrl: json['imageUrl'],
      title: json['title'],
      titleAr: json['titleAr'],
      author: json['author'],
      authorAr: json['authorAr'],
      subTitle: json['subTitle'],
      subTitleAr: json['subTitleAr'],
      tips: tipsList,
      references: json['references'],
      referencesAr: json['referencesAr'],
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> tipsList = [];
    if (tips != null) {
      tipsList = tips!.map((tip) => tip.toJson()).toList();
    }

    return {
      'articleId': articleId,
      'imageUrl': imageUrl,
      'title': title,
      'titleAr': titleAr,
      'author': author,
      'authorAr': authorAr,
      'subTitle': subTitle,
      'subTitleAr': subTitleAr,
      'tips': tipsList,
      'references': references,
      'referencesAr': referencesAr,
    };
  }

  ArticleModel copyWith({
    String? articleId,
    String? imageUrl,
    String? title,
    String? titleAr,
    String? author,
    String? authorAr,
    String? subTitle,
    String? subTitleAr,
    List<TipModel>? tips,
    String? references,
    String? referencesAr,
    List<dynamic>? tipsJson,
    List<TipModel>? tipsList,
  }) {
    return ArticleModel(
      articleId: articleId ?? this.articleId,
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      titleAr: titleAr ?? this.titleAr,
      author: author ?? this.author,
      authorAr: authorAr ?? this.authorAr,
      subTitle: subTitle ?? this.subTitle,
      subTitleAr: subTitleAr ?? this.subTitleAr,
      tips: tips ?? this.tips,
      references: references ?? this.references,
      referencesAr: referencesAr ?? this.referencesAr,
    );
  }
}

class TipModel {
  final String? title;
  final String? titleAr;
  final String? description;
  final String? descriptionAr;
  TipModel({
    this.titleAr,
    this.descriptionAr,
    this.title,
    this.description,
  });

  @override
  String toString() {
    return 'TipModel{title: $title, titleAr: $titleAr, description: $description, descriptionAr: $descriptionAr}';
  }

  factory TipModel.fromJson(Map<String, dynamic> json) {
    return TipModel(
      title: json['title'],
      titleAr: json['titleAr'],
      description: json['description'],
      descriptionAr: json['descriptionAr'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'titleAr': titleAr,
      'description': description,
      'descriptionAr': descriptionAr,
    };
  }

  TipModel copyWith({
    String? title,
    String? titleAr,
    String? description,
    String? descriptionAr,
  }) {
    return TipModel(
      title: title ?? this.title,
      titleAr: titleAr ?? this.titleAr,
      description: description ?? this.description,
      descriptionAr: descriptionAr ?? this.descriptionAr,
    );
  }
}

class MainArticleModel {
  final String? title;
  final String? titleAr;
  final String? articleId; //لايظهر
  final String? subtitle;
  final String? subtitleAr;
  final String? imageUrl;
  // final String? imageUrlAr;
  final ArticleModel? articleModel;

  MainArticleModel({
    this.articleModel,
    this.articleId,
    this.titleAr,
    this.subtitleAr,
    // this.imageUrlAr,
    this.title,
    this.subtitle,
    this.imageUrl,
  });

  @override
  String toString() {
    return 'MainArticleModel{title: $title, titleAr: $titleAr, articleId: $articleId, subtitle: $subtitle, subtitleAr: $subtitleAr, imageUrl: $imageUrl, articleModel: $articleModel}';
  }

  factory MainArticleModel.fromJson(Map<String, dynamic> json) {
    return MainArticleModel(
      articleModel: json['articleModel'] != null
          ? ArticleModel.fromJson(json['articleModel'])
          : null,
      articleId: json['articleId'],
      titleAr: json['titleAr'],
      subtitleAr: json['subtitleAr'],
      // imageUrlAr: json['imageUrlAr'],
      title: json['title'],
      subtitle: json['subtitle'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'articleId': articleId,
      'titleAr': titleAr,
      'subtitleAr': subtitleAr,
      // 'imageUrlAr': imageUrlAr,
      'title': title,
      'subtitle': subtitle,
      'imageUrl': imageUrl,
      'articleModel': articleModel?.toJson(),
    };
  }

  MainArticleModel copyWith({
    String? title,
    String? titleAr,
    String? articleId,
    String? subtitle,
    String? subtitleAr,
    String? imageUrl,
    ArticleModel? articleModel,
  }) {
    return MainArticleModel(
      title: title ?? this.title,
      titleAr: titleAr ?? this.titleAr,
      articleId: articleId ?? this.articleId,
      subtitle: subtitle ?? this.subtitle,
      subtitleAr: subtitleAr ?? this.subtitleAr,
      imageUrl: imageUrl ?? this.imageUrl,
      articleModel: articleModel ?? this.articleModel,
    );
  }
}

/// Tests
//
// // Create dummy data
// ArticleModel article = ArticleModel(
//   articleId: "123",
//   imageUrl: "https://example.com/image.jpg",
//   title: "Article Title",
//   titleAr: "عنوان المقالة",
//   author: "John Doe",
//   authorAr: "جون دو",
//   subTitle: "Sub Title",
//   subTitleAr: "عنوان فرعي",
//   tips: [
//     TipModel(
//       title: "Tip 1",
//       titleAr: "نص النصيحة 1",
//       description: "Description 1",
//       descriptionAr: "وصف 1",
//     ),
//     TipModel(
//       title: "Tip 2",
//       titleAr: "نص النصيحة 2",
//       description: "Description 2",
//       descriptionAr: "وصف 2",
//     ),
//   ],
//   references: "References",
//   referencesAr: "المراجع",
// );
//
// MainArticleModel mainArticle = MainArticleModel(
//   articleId: "456",
//   title: "Main Article Title",
//   titleAr: "عنوان المقالة الرئيسي",
//   subtitle: "Main Article Subtitle",
//   subtitleAr: "عنوان فرعي للمقالة الرئيسية",
//   imageUrl: "https://example.com/main-image.jpg",
//   // imageUrlAr: "https://example.com/main-image-ar.jpg",
//   articleModel: article,
// );
//
// Map<String, dynamic> articleMap = article.toJson();
//
// Future<void> saveMainArticleToFirestore(MainArticleModel mainArticle) async {
//   final firestoreInstance = FirebaseFirestore.instance;
//   Map<String, dynamic> mainArticleMap = mainArticle.toJson();
//   final mainArticleRef = firestoreInstance.collection("MainArticle").doc();
//   await mainArticleRef.set(mainArticleMap);
// }
//
// Future<MainArticleModel?> getMainArticleFromFirestore(String documentId) async {
//   final firestoreInstance = FirebaseFirestore.instance;
//   final mainArticleRef =
//       firestoreInstance.collection("MainArticle").doc(documentId);
//   final mainArticleSnapshot = await mainArticleRef.get();
//   if (mainArticleSnapshot.exists) {
//     final mainArticleData = mainArticleSnapshot.data()!;
//     MainArticleModel mainArticle = MainArticleModel.fromJson(mainArticleData);
//     return mainArticle;
//   } else {
//     return null;
//   }
// }
//
//
