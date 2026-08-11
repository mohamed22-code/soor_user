
import 'package:flutter/material.dart';
import 'package:soor_user_app/utils/app_colors.dart';

import '../utils/app_style.dart';

typedef OnValidator = String? Function(String?)?;

class CustomTextFormField extends StatelessWidget {
  Color borderSideColor;
  String? hintText;
  String? labelText;
  TextStyle? hintStyle;
  TextStyle? labelStyle;
  TextStyle? textStyle;
  Widget? prefixIcon;
  Widget?suffixIcon;
  OnValidator? validator;
  TextInputType? keyboardType;
  bool obscureText;
  int? maxLines;
  TextEditingController? controller;
   CustomTextFormField({super.key, this.borderSideColor = AppColors.darkGray,
   this.hintText, this.labelText, this.hintStyle, this.labelStyle, this.textStyle,
     this.prefixIcon, this.suffixIcon, this.validator,
     this.keyboardType = TextInputType.text, this.obscureText = false,
     required this.controller,this.maxLines = 1
   });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      controller: controller,
      style: textStyle??AppStyle.medium16darkGrey,
      decoration: InputDecoration(
        enabledBorder: builtDecorationBorder(borderSideColor: borderSideColor),
        focusedBorder: builtDecorationBorder(borderSideColor: borderSideColor),
        errorBorder: builtDecorationBorder(borderSideColor: Colors.red),
        focusedErrorBorder: builtDecorationBorder(borderSideColor: Colors.red),
        hintText: hintText,
        labelText: labelText,
        hintStyle: hintStyle?? AppStyle.bold16primary,
        labelStyle: labelStyle?? AppStyle.medium16primary,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon
      ),
    );
  }
}

OutlineInputBorder builtDecorationBorder({required Color borderSideColor}){
return OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
        color: borderSideColor,
      width: 2
    )
);
}