import 'package:flutter/material.dart';

import '../../../core/utils/app_style.dart';
import '../../../core/widget/custom_container_opinions.dart';

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
