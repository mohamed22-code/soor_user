import 'package:flutter/material.dart';

import '../themes/colors/app_colors.dart';
import '../themes/styles/app_style.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? text;
  final Color? borderColor;
  final TextStyle? textStyle;
  final bool hasIcon;
  final backgroundColor;
  final Widget? iconWidget;
  final Widget? childIconWidget;
  final double widthPadding;
  final double radius;
  final MainAxisAlignment? mainAxisAlignment;

  CustomElevatedButton({
    super.key,
    required this.onPressed,
    this.text,
    this.borderColor = Colors.transparent,
    this.backgroundColor = AppColors.secondaryDark,
    this.textStyle,
    this.hasIcon = false,
    this.iconWidget,
    this.mainAxisAlignment,
    this.childIconWidget,
    this.widthPadding = 20,
    this.radius = 8,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: backgroundColor,
        padding: EdgeInsets.symmetric(
          vertical: height * 0.01,
          horizontal: widthPadding,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: BorderSide(width: 2, color: borderColor!),
        ),
      ),
      onPressed: onPressed,
      child: Text(text ?? '', style: textStyle ?? AppStyle.medium16white),
    );
  }
}
