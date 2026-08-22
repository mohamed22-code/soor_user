import 'package:flutter/material.dart';

import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_routes.dart';
import '../../../core/utils/app_style.dart';
import '../../../core/widget/custom_elevated_button.dart';


class PasswordChange extends StatelessWidget {
  const PasswordChange({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Column(
            mainAxisAlignment: .center,
            children: [
              Spacer(),
              Image.asset(AppAssets.successImage),
              SizedBox(height: 10,),
              Text('تم بنجاح', style: AppStyle.bold24white,),
              SizedBox(height: 10,),
              Text('تم تغيير كلمه المرور بنجاح', style: AppStyle.medium16white,),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: CustomElevatedButton(
                  onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.homeRouteName);
                },
                text: 'تسجيل الدخول',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
