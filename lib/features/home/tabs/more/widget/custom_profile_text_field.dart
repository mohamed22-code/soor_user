import 'package:flutter/material.dart';

import '../../../../../core/themes/colors/app_colors.dart';
import '../../../../../core/themes/styles/app_style.dart';

class CustomProfileTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final VoidCallback? onTap;

  const CustomProfileTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.obscureText = false,
    this.controller,
    this.keyboardType,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            label,
            textAlign: TextAlign.right,
            style: AppStyle.medium16white,
          ),
          SizedBox(height: height * 0.01),

          TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,

            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            style: AppStyle.medium16white,
            decoration: InputDecoration(
              hintText: hintText,
              hintTextDirection: TextDirection.rtl,
              hintStyle: AppStyle.medium16darkGrey,
              prefixIcon: IconButton(
                onPressed: onTap,
                icon: const Icon(Icons.edit, color: Colors.white),
              ),

              filled: true,
              fillColor: AppColors.grayDark100Color,

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.grayDark100Color),
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.grayDark100Color),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
