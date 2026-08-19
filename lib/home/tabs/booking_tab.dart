import 'package:flutter/material.dart';
import 'package:soor_user_app/utils/app_colors.dart';
import 'package:soor_user_app/utils/app_style.dart';

import '../../widget/custom_container_booking.dart';

class BookingTab extends StatelessWidget {
  const BookingTab({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      appBar: AppBar(
        title: Text('الحجوزات', style: AppStyle.medium16white,),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: height * 0.02
        ),
        child: Column(
          crossAxisAlignment: .stretch,
          children: [
            CustomContainerBooking(
              bookingNumber: '#12336455',
              price: '1600 ريال',
              status: 'قبول الحارس',
              date: 'اليوم 8:00 م الى 11:00 م',
              color: Color(0xff00394C),
            ),
            SizedBox(height: height * 0.01,),
            CustomContainerBooking(
              bookingNumber: '#12336455',
              price: '1600 ريال',
              status: 'وصول الحارس',
              date: 'اليوم 8:00 م الى 11:00 م',
              color: AppColors.primaryText,
            ),
            SizedBox(height: height * 0.01,),
            CustomContainerBooking(
              bookingNumber: '#12336455',
              price: '1600 ريال',
              status: 'منتهي',
              date: 'اليوم 8:00 م الى 11:00 م',
              onAddReview: () {
                // todo: navigate to rate
              },
            ),
          ],
        ),
      ),
    );
  }
}
