import 'package:flutter/material.dart';
import 'package:soor_user_app/core/themes/colors/app_colors.dart';
import 'package:soor_user_app/features/home/tabs/service/add_details/add_details_screen.dart';
import 'package:soor_user_app/features/home/tabs/service/custom_contianer_service.dart';

import '../../../../core/themes/styles/app_style.dart';
import '../../../../core/widgets/custom_container_opinions.dart';
import '../../../../core/widgets/custom_elevated_button.dart';

class ServicesTab extends StatelessWidget {
  ServicesTab({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('الخدمات', style: AppStyle.bold24white),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: height * 0.02,
          horizontal: width * 0.04,
        ),
        child: Column(
          children: [
            CustomContianerService(
              text: 'طلب فرد',
              color: Colors.orange,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddDetailsScreen()),
                );
              },
            ),
            SizedBox(height: height * 0.02),
            CustomContianerService(
              text: 'مناسبات',
              color: Color(0xff007AA2),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddDetailsScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
