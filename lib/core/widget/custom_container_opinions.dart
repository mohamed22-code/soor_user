import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_style.dart';

class CustomContainerOpinions extends StatelessWidget {
  const CustomContainerOpinions({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.appBarColor,
      ),
      child: Row(
        crossAxisAlignment: .start,
        children: [
          Column(
            crossAxisAlignment: .start,
            children: [
              Text('محمد احمد ابراهيم', style: AppStyle.bold14white),
              SizedBox(height: height * 0.02),
              Text(
                'خدمة ممتازة مع الالتزام فى المواعيد',
                style: AppStyle.medium16darkGrey,
              ),
            ],
          ),

          Icon(Icons.star, size: 25, color: Colors.orange),
          Icon(Icons.star, size: 25, color: Colors.orange),
          Icon(Icons.star, size: 25, color: Colors.orange),
          Icon(Icons.star, size: 25, color: Colors.orange),
          Icon(Icons.star, size: 25, color: Colors.orange),
        ],
      ),
    );
  }
}
