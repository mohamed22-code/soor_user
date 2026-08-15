import 'package:flutter/material.dart';
import 'package:soor_user_app/utils/app_colors.dart';

class CustomContainerBooking extends StatelessWidget {
  const CustomContainerBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.appBarColor,

      ),
    );
  }
}
