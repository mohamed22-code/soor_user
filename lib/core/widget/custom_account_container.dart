import 'package:flutter/material.dart';

import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../utils/app_style.dart';

class CustomAccountContainer extends StatelessWidget {
  const CustomAccountContainer({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.01,
      ),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.accountColor,
      ),
      width: double.infinity,
      height: height * 0.1,
      child: Row(
        children: [
          Image.asset(AppAssets.avatarChatImage),
          SizedBox(width: width * 0.01),
          Column(
            mainAxisAlignment: .spaceAround,
            children: [
              Text('كريم خليل السيد', style: AppStyle.bold16white),
              Text('+9054545656', style: AppStyle.medium14darkGrey),
            ],
          ),
          Spacer(),
          Icon(Icons.edit, color: Colors.white, size: 20),
        ],
      ),
    );
  }
}
