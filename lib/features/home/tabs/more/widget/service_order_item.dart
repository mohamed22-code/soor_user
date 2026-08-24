import 'package:flutter/material.dart';

import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/themes/colors/app_colors.dart';
import '../../../../../core/themes/styles/app_style.dart';

class ServiceOrderItem extends StatelessWidget {
  final String name;
  final String service;
  final String time;
  final int? count;
  final VoidCallback? onTap;

  const ServiceOrderItem({
    super.key,
    required this.name,
    required this.service,
    required this.time,
    this.count,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: height * 0.12,
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: height * 0.02,
          ),
          decoration: BoxDecoration(
            color: AppColors.grayDark100Color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(time, style: AppStyle.medium16darkGrey),
                  Icon(Icons.done_all, color: AppColors.primaryText, size: 20),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      count != null
                          ? Container(
                              width: 28,
                              height: 28,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '$count',
                                style: AppStyle.bold14white,
                              ),
                            )
                          : SizedBox(),
                      SizedBox(width: width * 0.01),
                      Text(name, style: AppStyle.medium16primary),
                    ],
                  ),
                  SizedBox(height: height * 0.01),
                  Text(service, style: AppStyle.medium16white),
                ],
              ),
              SizedBox(width: width * 0.02),
              Image.asset(AppAssets.soorNotificationImage),
            ],
          ),
        ),
      ),
    );
  }
}
