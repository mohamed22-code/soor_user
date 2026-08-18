import 'package:flutter/material.dart';
import 'package:soor_user_app/utils/app_colors.dart';

import '../utils/app_style.dart';
import 'custom_elevated_button.dart';

class CustomContainerBooking extends StatelessWidget {
  const CustomContainerBooking({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var height = MediaQuery
        .of(context)
        .size
        .height;
    return Container(
      width: width * 0.92,
      height: height * 0.16,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.appBarColor,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.02),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: .spaceAround,
              children: [
                Text('#12336455', style: AppStyle.bold16white,),
                Text('1600 ريال', style: AppStyle.bold16primary,),
                Text('اضافه تقييم >', style: AppStyle.bold16primary,),
              ],
            ),
            Spacer(),
            Column(
              children: [
                CustomElevatedButton(

                  onPressed: () {

                  }, text: 'منتهي', backgroundColor: AppColors.sucessColor,
                  radius: 360,

                ),
                Text('اليوم 8:00 م الى 11:00 م',
                  style: AppStyle.medium16darkGrey,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
