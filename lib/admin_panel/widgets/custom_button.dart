import 'package:adhd_app/utiles/colors.dart';
import 'package:flutter/material.dart';

class CustomAdminButton extends StatelessWidget {
  const CustomAdminButton(
      {Key? key, this.onPressed, required this.title, this.backgroundColor})
      : super(key: key);
  final void Function()? onPressed;
  final String title;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.width * 0.1,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.mainColor,
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
