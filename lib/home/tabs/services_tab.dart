import 'package:flutter/material.dart';
import 'package:soor_user_app/utils/app_colors.dart';
import 'package:soor_user_app/widget/custom_container_opinions.dart';
import 'package:soor_user_app/widget/custom_container_services.dart';

import '../../utils/app_style.dart';

class ServicesTab extends StatelessWidget {
  const ServicesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('الخدمات', style: AppStyle.bold24white),
      ),
      body: CustomContainerOpinions(),
    );
  }
}
