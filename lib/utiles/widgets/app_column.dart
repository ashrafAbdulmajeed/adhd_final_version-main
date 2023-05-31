import 'package:adhd_app/utiles/widgets/big_text.dart';
import 'package:adhd_app/utiles/widgets/icon_and_text_widget.dart';
import 'package:adhd_app/utiles/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AppColumn extends StatelessWidget {
  final String doctorName;
  AppColumn({Key? key, required this.doctorName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: doctorName,
          size: 26,
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Wrap(
              children: List.generate(
                  5,
                  (index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 15,
                      )),
            ),
            const SizedBox(
              width: 10,
            ),
            SmallText(text: "4.9"),
            const SizedBox(
              width: 10,
            ),
            IconAndTextWidget(
                icon: Icons.circle_sharp,
                iconColor: Colors.grey,
                iconSize: 12,
                text: 'ADHD Specialist'),
          ],
        ),
       
      ],
    );
  }
}
