import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class BigText extends StatelessWidget {
  String text;
  TextOverflow? overflow;
  Color? color;
  double? size;
  BigText({Key? key, required this.text, this.overflow = TextOverflow.ellipsis, this.color = const Color(0xFF332d2b), this.size=0})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: TextStyle(
        fontFamily: 'Roboto',
        color: color,
        fontSize: size==0?20:size,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
