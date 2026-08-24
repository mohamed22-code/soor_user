import 'package:flutter/material.dart';

import '../../core/utils/app_assets.dart';
import '../../core/themes/colors/app_colors.dart';
import '../../core/themes/styles/app_style.dart';

class NotificationScreen extends StatelessWidget {
  var height;
  var width;

  NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.close),
        title: Text('الاشعارات', style: AppStyle.medium16white),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            SizedBox(height: height * 0.01),
            Text('اليوم', style: AppStyle.medium16darkGrey),
            SizedBox(height: height * 0.01),
            builtContainerNotification(),
            SizedBox(height: height * 0.01),
            builtContainerNotification(),
            SizedBox(height: height * 0.01),
            Text('امس', style: AppStyle.medium16darkGrey),
            SizedBox(height: height * 0.01),
            builtContainerNotification(),
            SizedBox(height: height * 0.01),
            Text('30-10-2025', style: AppStyle.medium16darkGrey),
            SizedBox(height: height * 0.01),
            builtContainerNotification(),
          ],
        ),
      ),
    );
  }

  builtContainerNotification() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.02,
        vertical: height * 0.01,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: AppColors.grayDark100Color,
      ),
      child: Row(
        crossAxisAlignment: .start,
        children: [
          Image.asset(AppAssets.soorNotificationImage),
          SizedBox(width: width * 0.02),
          Column(
            children: [
              Text('تم قبول الطلب بنجاح', style: AppStyle.medium16white),
              SizedBox(height: height * 0.01),
              Text(
                'الحارس فى طريقه اليك',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.describtionColor,
                ),
              ),
            ],
          ),
          Spacer(),
          Text(
            '13.47',
            style: TextStyle(fontSize: 12, color: AppColors.describtionColor),
          ),
        ],
      ),
    );
  }
}
