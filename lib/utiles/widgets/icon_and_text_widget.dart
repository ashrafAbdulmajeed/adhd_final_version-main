import 'package:adhd_app/utiles/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String text;
  double? iconSize;
  IconAndTextWidget({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.text,
    this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: iconSize??24,),
          SizedBox(width: 5,),
          SmallText(text: text,),
        ],
      ),
    );
  }
}