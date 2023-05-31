import 'package:adhd_app/admin_panel/users_panel/update_user_screen.dart';
import 'package:adhd_app/injection_container.dart';
import 'package:adhd_app/models/article.dart';
import 'package:adhd_app/models/user_model.dart';
import 'package:adhd_app/screens/specialists/specialist_details_screen.dart';
import 'package:adhd_app/utiles/colors.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UsersOperations {
  static Stream<List<MainArticleModel>> getAllMainArticles() {
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

  static deleteArticle(
      {required String articleId, required BuildContext context}) async {
    try {
      final doctorRef =
          FirebaseFirestore.instance.collection('MainArticle').doc(articleId);

      // Delete the doctor's data from Firestore
      await doctorRef.delete();

      // Delete the doctor's image file from Firebase Storage
      final storage =
          FirebaseStorage.instance.ref().child('articles/$articleId.jpg');
      await storage.delete().then((v) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Article deleted successfully')),
        );
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete Article')),
      );
    }
  }

  static Future<void> deleteDoctor(
      {required String doctorId, required BuildContext context}) async {
    try {
      final doctorRef =
          FirebaseFirestore.instance.collection('doctors').doc(doctorId);

      // Delete the doctor's data from Firestore
      await doctorRef.delete();

      // Delete the doctor's image file from Firebase Storage
      final storage =
          FirebaseStorage.instance.ref().child('doctors/$doctorId.jpg');
      await storage.delete().then((v) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Doctor deleted successfully')),
        );
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete doctor')),
      );
    }
  }

  static Future<void> deleteUser({required String userId}) async {
    ///TODO fire base cloud function not free. we need it to delete user from firebaseAuth
    await sl<FirebaseFirestore>().collection("users").doc(userId).delete();
  }

  static adminDialog({
    required BuildContext context,
    required int adminPermission,
    required String userId,
    required UserModel data,
  }) {
    AwesomeDialog(
        dismissOnBackKeyPress: true,
        dismissOnTouchOutside: true,
        closeIcon: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
            color: Colors.red,
          ),
        ),
        customHeader: CircleAvatar(
          radius: 45,
          foregroundImage: (!(data.image.toString().startsWith('assets')) &&
                      data.image != null
                  ? NetworkImage(data.image.toString())
                  : const AssetImage("assets/images/avatar.jpg"))
              as ImageProvider<Object>?,
        ),
        dialogBackgroundColor: Colors.white,
        context: context,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              infoCardBuilder(
                // title: "User Name".tr(context),
                title: "User Name",

                subTitle: data.username.toString(),
                icon: FontAwesomeIcons.userAstronaut,
              ),
              infoCardBuilder(
                // title: "Role :".tr(context),
                title: "Role :",

                subTitle: "${data.role} User",
                icon: FontAwesomeIcons.userPlus,
              ),
              infoCardBuilder(
                // title: "Email".tr(context),
                title: "Email",
                subTitle: data.email.toString(),
                icon: FontAwesomeIcons.inbox,
              ),
              infoCardBuilder(
                // title: "Email".tr(context),
                title: "Phone Number",
                subTitle: data.phone.toString(),
                icon: FontAwesomeIcons.phone,
              ),
            ],
          ),
        ),
        btnCancelIcon: FontAwesomeIcons.drumSteelpan,
        btnCancelOnPress: () async {
          try {
            await UsersOperations.deleteUser(userId: userId).then((value) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "deleted Succfully",
                  ),
                ),
              );
            });
          } on FirebaseException catch (e) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.message.toString())));
          }
        },
        btnCancelText: " Delete",
        btnCancelColor: Colors.red,
        btnOkIcon: FontAwesomeIcons.expeditedssl,
        btnOkColor: AppColors.mainColor,
        btnOkText: " Update",
        buttonsTextStyle: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Colors.white, fontSize: 14),
        btnOkOnPress: () {
          Navigator.pop(context);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => UpdateUserScreen(
                userModel: data,
              ),
            ),
          );
        }).show();
  }
}
