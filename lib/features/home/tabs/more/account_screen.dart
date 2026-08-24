import 'package:flutter/material.dart';
import 'package:soor_user_app/features/home/tabs/more/widget/custom_profile_text_field.dart';
import '../../../../core/themes/styles/app_style.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('الحساب', style: AppStyle.medium16white),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: height * 0.02,
          ),
          child: Column(
            children: [
              CustomProfileTextField(
                label: 'رقم الجوال',
                hintText: '+966 000 000 00',
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: height * 0.02),
              CustomProfileTextField(
                label: 'البريد الإلكتروني',
                hintText: 'info@gmail.com',
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: height * 0.02),
              CustomProfileTextField(
                label: 'الاسم كامل',
                hintText: 'أحمد محمد',
              ),
              SizedBox(height: height * 0.02),
              CustomProfileTextField(
                label: 'كلمة المرور',
                hintText: '*********',
                obscureText: true,
              ),
              SizedBox(height: height * 0.02),
              CustomProfileTextField(
                label: 'تأكيد كلمة المرور',
                hintText: '*********',
                obscureText: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
