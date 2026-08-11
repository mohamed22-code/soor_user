import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_style.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? text;
  final Color? backgroundColor;
  final Color? borderColor;
  final TextStyle? textStyle;
  final bool hasIcon;
  final Widget? iconWidget;
  final Widget? childIconWidget;
  final MainAxisAlignment? mainAxisAlignment;
  const CustomElevatedButton({super.key, required this.onPressed, this.text,
  this.backgroundColor = AppColors.secondaryDark, this.borderColor = Colors.transparent,
    this.textStyle, this.hasIcon = false, this.iconWidget,this.mainAxisAlignment,
    this.childIconWidget

  });
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: backgroundColor,
        padding: EdgeInsets.symmetric(vertical: height*0.02),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            width: 2,
            color: borderColor!
          )
        )
      ),
        onPressed: onPressed,
        child: Text(text??'',style: textStyle??AppStyle.medium16white,));
  }
}
