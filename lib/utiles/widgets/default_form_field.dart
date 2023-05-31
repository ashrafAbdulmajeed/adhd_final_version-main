import 'package:adhd_app/utiles/colors.dart';
import 'package:flutter/material.dart';

class DefaultFormField extends StatelessWidget {
  String? label;
  TextEditingController? controller;
  TextInputType? type;
  void Function(String)? onSubmit;
  void Function(String)? onChange;
  void Function(String?)? onSaved;
  void Function()? onTap;
  bool isPassword = false;
  String? Function(String?)? validate;
  IconData? prefix;
  IconData? suffix;
  IconButton? suffixIcon;
  void Function()? suffixPressed;
  bool isClickable = true;
  bool isSuffix = false;
  int? minLines;
  int? maxLines;
  double? borderWidth;
  String? hintText;
  Color? prefixColorIcon;
  Color? fillColor;
  Color? hintColor;
  Color borderColor = Colors.grey;
  Color? labelColor;
  Color focusedColorBorder;
  String? intialVal;
  bool? readOnly;
  bool autoFocus;

  Key? key;
  bool? secureText;

  AutovalidateMode? autovalidateMode;

  DefaultFormField({
    this.key,
    this.autovalidateMode,
    this.controller,
    this.isClickable = true,
    this.isPassword = false,
    this.isSuffix = false,
    this.label,
    this.onChange,
    this.onSaved,
    this.onSubmit,
    this.onTap,
    this.prefix,
    this.suffix,
    this.suffixPressed,
    this.type,
    this.validate,
    this.minLines,
    this.maxLines,
    this.borderWidth = 10.0,
    this.hintText,
    this.prefixColorIcon,
    this.fillColor,
    this.hintColor,
    required this.borderColor,
    this.labelColor,
    this.focusedColorBorder = Colors.grey,
    this.intialVal,
    this.readOnly,
    this.suffixIcon,
    this.autoFocus = false,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: autovalidateMode,
      key: key,
      controller: controller,
      style: Theme.of(context).textTheme.bodyText2,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onSaved: onSaved,
      autofocus: autoFocus,
      cursorColor: AppColors.mainColor,
      onChanged: onChange,
      initialValue: intialVal,
      onTap: onTap,
      validator: validate,
      minLines: minLines,
      readOnly: readOnly ?? false,
      maxLines: maxLines,
      decoration: InputDecoration(
        fillColor: Colors.white,
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.mainColor, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(borderWidth!)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(borderWidth!)),
        ),
        filled: true,
        // fillColor: Theme.of(context).cardColor,
        hintText: hintText,
        hintStyle: TextStyle(color: hintColor),
        // contentPadding:
        //     const EdgeInsets.only(top: 10, bottom: 10, left: 20),
        focusColor: AppColors.mainColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderWidth ?? 50.0),
          borderSide: BorderSide(
            color: AppColors.mainColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderWidth ?? 50.0),
          borderSide: BorderSide(
            color: AppColors.mainColor,
          ),
        ),
        labelText: label,
        labelStyle: TextStyle(color: labelColor),
        prefixIcon: Icon(
          prefix,
          color: prefixColorIcon ?? AppColors.mainColor,
        ),
        suffixIcon: isSuffix
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                  color: AppColors.mainColor,
                ))
            : null,
      ),
    );
  }
}
