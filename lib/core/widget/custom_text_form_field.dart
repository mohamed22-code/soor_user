import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_style.dart';

typedef OnValidator = String? Function(String?)?;

class CustomTextFormField extends StatefulWidget {
  Color borderSideColor;
  String? hintText;
  String? labelText;
  TextStyle? hintStyle;
  TextStyle? labelStyle;
  TextStyle? textStyle;
  Widget? prefixIcon;
  Widget? suffixIcon;
  OnValidator? validator;
  TextInputType? keyboardType;
  bool obscureText;
  int? maxLines;
  TextEditingController? controller;

  CustomTextFormField({
    super.key,
    this.borderSideColor = AppColors.borderSideColor,
    this.hintText,
    this.labelText,
    this.hintStyle,
    this.labelStyle,
    this.textStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    required this.controller,
    this.maxLines = 1,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool isObscure;

  @override
  void initState() {
    isObscure = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      obscureText: isObscure,
      controller: widget.controller,
      style: widget.textStyle ?? AppStyle.medium16darkGrey,
      decoration: InputDecoration(
        enabledBorder: builtDecorationBorder(
          borderSideColor: widget.borderSideColor,
        ),
        focusedBorder: builtDecorationBorder(
          borderSideColor: widget.borderSideColor,
        ),
        errorBorder: builtDecorationBorder(borderSideColor: Colors.red),
        focusedErrorBorder: builtDecorationBorder(borderSideColor: Colors.red),
        hintText: widget.hintText,
        labelText: widget.labelText,
        hintStyle: widget.hintStyle ?? AppStyle.bold16primary,
        labelStyle: widget.labelStyle ?? AppStyle.medium16primary,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.obscureText
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility),
              )
            : widget.suffixIcon,
      ),
    );
  }
}

OutlineInputBorder builtDecorationBorder({required Color borderSideColor}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: borderSideColor, width: 2),
  );
}
