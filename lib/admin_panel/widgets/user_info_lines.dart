import 'package:adhd_app/utiles/colors.dart';
import 'package:flutter/material.dart';

class UserInfoLines extends StatelessWidget {
  const UserInfoLines({Key? key, required this.title, required this.value})
      : super(key: key);
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: AppColors.mainColor,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
    return ListTile(
      leading: Title(
        color: Colors.purple,
        child: Text(
          title,
        ),
      ),
      title: Title(
        color: Colors.black,
        child: Text(value),
      ),
    );
  }
}
