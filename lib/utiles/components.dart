import 'package:adhd_app/utiles/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Navigate component
void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(
  context,
  widget,
) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) {
        return false;
      },
    );

// Divider component
Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget defaultTextButton({
  required Function function,
  required String text,
}) =>
    TextButton(
      onPressed: () {
        function;
      },
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: AppColors.mainColor,
        ),
      ),
    );

Widget filledButtonV2({title, onPressed, radius, fullWidth = true}) {
  return Center(
    child: Container(
      width: fullWidth ? double.infinity : null,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 50.0),
        color: AppColors.mainColor,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ),
    ),
  );
}

Widget filledButton(context, {title, onTap, bgcolor, txtColor}) {
  return SizedBox(
    width: 150,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // <-- Radius
          ),
          primary: bgcolor,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            title,
            style: TextStyle(
              color: txtColor,
              fontSize: 20.0,
              fontFamily: 'SF-Pro-Rounded',
            ),
          ),
          Icon(Icons.arrow_forward_ios)
        ],
      ),
    ),
  );
}

Widget filledButtonWithIcon({title, onPressed, radius, icon, isSvg = false}) {
  return Center(
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 50.0),
        color: AppColors.mainColor,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!isSvg)
              Icon(
                icon,
                color: Colors.white,
              ),
            if (isSvg) icon,
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget iconButton({bg, onPressed, radius, icon, isSvg = false}) {
  return Center(
    child: Container(
      // width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 50.0),
        color: bg ?? AppColors.mainColor,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!isSvg)
              Icon(
                icon,
                color: Colors.white,
              ),
            if (isSvg) icon,
          ],
        ),
      ),
    ),
  );
}

Widget loginWithBuilder(context, websiteSvg, loginWith, onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(10),
        border: Border.all(
          color: Color.fromARGB(255, 216, 216, 216),
        ),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
          top: 15.0,
          bottom: 15.0,
          start: 20,
          end: 20,
        ),
        child: SvgPicture.asset(
          websiteSvg,
          width: 35,
          height: 35,
        ),
      ),
    ),
  );
}

Widget titleWithIcon({title, icon}) {
  return Row(
    children: [
      Icon(
        icon,
        color: AppColors.mainColor,
      ),
      const SizedBox(
        width: 5,
      ),
      Text(
        title,
        style: GoogleFonts.lato(
          textStyle: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}

showCustomSnackBar(BuildContext context,
    {required String content,
    required Color bgColor,
    required Color textColor}) {
  final snackBar = SnackBar(
    content: Text(
      content,
      style: TextStyle(
        color: textColor,
      ),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    backgroundColor: bgColor.withOpacity(0.7),
    elevation: 0,
    behavior: SnackBarBehavior.floating,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
