import 'package:flutter/material.dart';

class CheckBoxWidget extends StatelessWidget {

   CheckBoxWidget({
    this.label,
    this.padding,
    this.value,
    this.onChanged,
  });

  final String? label;
  final EdgeInsets? padding;
  final bool? value;
  final Function? onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged!(value);
      },
      child: Padding(
        padding: padding!,
        child: Row(
          children: <Widget>[
            Checkbox(
              value: value,
              onChanged: (bool? newValue) {
                onChanged!(newValue);
              },
            ),
            Expanded(child: Text(
              label!,
              style: TextStyle(
                fontSize: 17,
              )
            )),
          ],
        ),
      ),
    );
  }
}