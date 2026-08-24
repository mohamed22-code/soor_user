import 'package:flutter/material.dart';

import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/styles/app_style.dart';
import '../../../../core/widgets/custom_elevated_button.dart';

class CustomContianerService extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;

  const CustomContianerService({
    super.key,
    required this.text,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    var heigth = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.appBarColor,
      ),
      height: heigth * 0.25,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: .center,
        children: [
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(360),
              color: color,
            ),
            child: Icon(Icons.person, size: 30, color: Colors.white),
          ),
          SizedBox(height: heigth * 0.02),
          Text(text, style: AppStyle.bold20white),
          Text('وصف الخدمه هنا', style: AppStyle.medium16darkGrey),
          Column(
            crossAxisAlignment: .stretch,
            children: [
              CustomElevatedButton(
                widthPadding: 40,
                mainAxisAlignment: MainAxisAlignment.center,
                onPressed: onPressed,
                text: 'ابدء الان >',
                textStyle: AppStyle.bold20white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
