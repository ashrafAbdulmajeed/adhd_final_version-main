import 'package:adhd_app/utiles/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Utils {
  static List<Widget> heightBetween(
    List<Widget> children, {
    required double height,
  }) {
    if (children.isEmpty) return <Widget>[];
    if (children.length == 1) return children;

    final list = [children.first, SizedBox(height: height)];
    for (int i = 1; i < children.length - 1; i++) {
      final child = children[i];
      list.add(child);
      list.add(SizedBox(height: height));
    }
    list.add(children.last);

    return list;
  }

  static showLoaderDialog(BuildContext context, text) {
    AlertDialog alert = AlertDialog(
      content: Container(
        height: MediaQuery.of(context).size.height * .3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset(Resources.loading,
                height: MediaQuery.of(context).size.height * 0.2),
            Container(
                margin: const EdgeInsets.only(top: 10),
                child: Text(text ?? "Loading...")),
          ],
        ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
