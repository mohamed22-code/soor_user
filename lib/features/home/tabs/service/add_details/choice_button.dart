import 'package:flutter/material.dart';
import 'package:soor_user_app/core/themes/colors/app_colors.dart';
import 'package:soor_user_app/core/themes/styles/app_style.dart';

class ChoiceButton extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const ChoiceButton({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 30,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected
                ? AppColors.primaryText
                : AppColors.grayDark100Color,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            selected
                ? Icon(Icons.check, color: AppColors.primaryText, size: 14)
                : const SizedBox(),
            const SizedBox(width: 5),

            Text(title, style: AppStyle.bold12white),
          ],
        ),
      ),
    );
  }
}
