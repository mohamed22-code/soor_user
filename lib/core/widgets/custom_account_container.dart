import 'package:flutter/material.dart';

import '../utils/app_assets.dart';
import '../themes/colors/app_colors.dart';
import '../themes/styles/app_style.dart';

class CustomAccountContainer extends StatelessWidget {
  final String? name;
  final String? phone;

  const CustomAccountContainer({super.key, this.name, this.phone});

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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(name ?? 'كريم خليل السيد', style: AppStyle.bold16white),
              Text(phone ?? '+9054545656', style: AppStyle.medium14darkGrey),
            ],
          ),
          const Spacer(),
          const Icon(Icons.edit, color: Colors.white, size: 20),
        ],
      ),
    );
  }
}
