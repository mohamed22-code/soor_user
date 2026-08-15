import 'package:flutter/material.dart';
import 'package:soor_user_app/utils/app_assets.dart';
import 'package:soor_user_app/utils/app_colors.dart';
import 'package:soor_user_app/utils/app_style.dart';
import 'package:soor_user_app/widget/custom_text_form_field.dart';

import '../../utils/app_routes.dart';
import '../../widget/custom_elevated_button.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController(text: '01014603733');
  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width*0.04),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: .stretch,
            children: [
              // SizedBox(height: height*0.01,),
              Image.asset(AppAssets.soorLogo),
              SizedBox(height: height*0.02,),
              Text('هل نسيت كلمه المرور؟', style: AppStyle.bold24white,textAlign: .center,),
              SizedBox(height: height*0.02,),
              Form(
                key: formKey,
                  child: Column(
                crossAxisAlignment: .stretch,
                    children: [
                      Text('رقم الجوال', style: AppStyle.bold16white,),
                      SizedBox(height: height*0.01,),
                      CustomTextFormField(
                        hintText: '+966 000 000 00',
                        keyboardType: TextInputType.phone,
                        controller: phoneController,
                        validator: (text) {
                          if(text == null ||text.trim().isEmpty){
                            return 'please enter your phone'; // todo: invalid
                          }
                          final bool phoneValid = RegExp(
                            r'^01[0125][0-9]{8}$',
                          ).hasMatch(text.trim());

                          if (!phoneValid) {
                            return 'Please enter a valid phone number';
                          }

                          return null;

                        },
                      ),
                    ],
              )),
              SizedBox(height: height*0.02,),
              CustomElevatedButton(
                widthPadding: 40,
                mainAxisAlignment: MainAxisAlignment.center,
                onPressed: verification,
                text: 'ارسال',
                textStyle: AppStyle.bold20white,
              ),
            ],
          ),
        ),
      ),
    );
  }
  void verification() {
    if(formKey.currentState?.validate() == true){
      //todo: send OTP
      Navigator.of(context).pushNamed(AppRoutes.verificationPasswordRouteName,arguments: phoneController.text);
    }
  }
}
