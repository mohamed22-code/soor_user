import 'package:flutter/material.dart';

import '../themes/colors/app_colors.dart';
import '../themes/styles/app_style.dart';

class SettingItemContainer extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  final Widget? trailing;

  const SettingItemContainer({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.08,
      decoration: BoxDecoration(
        color: AppColors.appBarColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          child: Row(
            children: [
              Icon(icon, color: AppColors.darkGray, size: 24),
              SizedBox(width: width * 0.02),
              Text(title, style: AppStyle.medium16white),
              Spacer(),
              trailing ??
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: AppColors.darkGray,
                    size: 24,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
