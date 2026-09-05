import 'package:flutter/material.dart';

import '../themes/colors/app_colors.dart';
import '../themes/styles/app_style.dart';

class CustomContainerOpinions extends StatelessWidget {
  final String name;
  final String comment;
  final int rating;

  const CustomContainerOpinions({
    super.key,
    this.name = 'محمد احمد ابراهيم',
    this.comment = 'خدمة ممتازة مع الالتزام فى المواعيد',
    this.rating = 5,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.03,
        vertical: height * 0.015,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.appBarColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppStyle.bold14white),
                SizedBox(height: height * 0.008),
                Text(
                  comment,
                  style: AppStyle.medium16darkGrey,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: width * 0.02),
          Row(
            children: List.generate(
              5,
              (i) => Icon(
                Icons.star,
                size: 18,
                color: i < rating ? Colors.orange : Colors.white24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
