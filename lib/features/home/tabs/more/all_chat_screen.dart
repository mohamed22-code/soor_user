import 'package:flutter/material.dart';
import 'package:soor_user_app/features/home/tabs/more/widget/service_order_item.dart';

import '../../../../core/utils/app_style.dart';

class AllChatScreen extends StatelessWidget {
  const AllChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('المحادثات', style: AppStyle.medium16white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              ServiceOrderItem(
                name: 'Soor',
                service: 'خدمه ممتازه',
                time: '13.47',
                count: 3,
              ),
              SizedBox(height: 15),
              ServiceOrderItem(
                name: 'Soor',
                service: 'خدمه ممتازه',
                time: '13.47',
              ),
              SizedBox(height: 15),
              ServiceOrderItem(
                name: 'Soor',
                service: 'خدمه ممتازه',
                time: '13.47',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
