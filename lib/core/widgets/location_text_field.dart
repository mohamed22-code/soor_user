import 'package:flutter/material.dart';
import 'package:soor_user_app/core/themes/styles/app_style.dart';

import '../themes/colors/app_colors.dart';

class LocationTextField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final int maxLines;

  const LocationTextField({
    super.key,
    required this.hint,
    this.controller,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        textAlign: TextAlign.right,
        style: AppStyle.bold16white,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(fontSize: 16, color: Color(0xff616161)),
          filled: true,
          fillColor: AppColors.grayDark100Color,
          contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: AppColors.borderSideColor,
              width: 1.2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: AppColors.borderSideColor,
              width: 1.2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppColors.primaryText, width: 1.4),
          ),
        ),
      ),
    );
  }
}
