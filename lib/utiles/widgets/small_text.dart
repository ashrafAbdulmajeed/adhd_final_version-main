import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class SmallText extends StatelessWidget {
  String text;
  Color? color;
  double? size;
  double? height;
  int? maxLines;
  SmallText({Key? key, required this.text, this.color = const Color(0xFFccc7c5), this.size=12, this.height=1.2, this.maxLines})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      style: TextStyle(
        fontFamily: 'Roboto',
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w400,
        height: height
      ),
    );
  }
}
