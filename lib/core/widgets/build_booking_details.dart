import 'package:flutter/material.dart';

import '../themes/colors/app_colors.dart';
import '../themes/styles/app_style.dart';

class BuildBookingDetails extends StatelessWidget {
  const BuildBookingDetails({super.key, required this.infoItem});

  final Widget infoItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: BoxBorder.all(width: 2, color: AppColors.grayDark100Color),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('تفاصيل الحجز', style: AppStyle.medium16darkGrey),
              Text('1550 ريال', style: AppStyle.bold16primary),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: infoItem),
              Expanded(child: infoItem),
            ],
          ),
          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text('عرض المزيد', style: AppStyle.medium16darkGrey),
                  const SizedBox(width: 5),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
