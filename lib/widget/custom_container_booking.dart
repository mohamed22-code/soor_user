import 'package:flutter/material.dart';
import 'package:soor_user_app/utils/app_colors.dart';

import '../utils/app_style.dart';
import 'custom_elevated_button.dart';

class CustomContainerBooking extends StatelessWidget {
  final String bookingNumber;
  final String price;
  final String date;
  final String status;
  final Color? color;
  final VoidCallback? onAddReview;

  const CustomContainerBooking({super.key,
    required this.bookingNumber,
    required this.price,
    required this.date,
    required this.status,
    this.color,
    this.onAddReview,});

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
    final bool isFinished = status == 'منتهي';
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
                Text(bookingNumber, style: AppStyle.bold16white,),
                Text(price, style: AppStyle.bold16primary,),
                isFinished ? InkWell(
                  onTap: onAddReview,
                  child: Text('اضافه تقييم >', style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff2D9EC4)
                  ),),
                ) : SizedBox(),

              ],
            ),
            Spacer(),
            Column(
              children: [
                CustomElevatedButton(

                  onPressed: () {

                  },
                  text: status,
                  backgroundColor: color ?? AppColors.sucessColor,
                  radius: 360,

                ),
                Text(date,
                  style: AppStyle.medium16darkGrey,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
