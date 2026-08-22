import 'package:flutter/material.dart';

import '../../core/utils/app_assets.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_routes.dart';
import '../../core/utils/app_style.dart';
import '../../core/widget/custom_elevated_button.dart';
import '../../core/widget/custom_text_form_field.dart';
import '../../l10n/app_localizations.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController phoneController = TextEditingController(text: '01014603733');

  TextEditingController passwordController = TextEditingController(text: '123456');
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        title: Row(
          children: [
            Image.asset(AppAssets.languageIcon),
            SizedBox(width: width*0.01,),
            Text('English', style: AppStyle.medium16primary,),
          ],
        ),
        actions: [
          Icon(Icons.close, color: Colors.white,),
          SizedBox(width: width*0.02,),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width*0.03),
        child: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: .center,
            children: [

              Image.asset(AppAssets.soorLogo),
              SizedBox(height: height*0.04,),
              Text(AppLocalizations.of(context)!.welcome, style: AppStyle.bold24white,),
              Text('مع سور ... انت فى السيلم ، قم بتسجيل الدخول الآن', style: AppStyle.medium16white,),
              SizedBox(height: height*0.02,),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: .stretch,
                  children: [
                    Text('رقم الجوال',style: AppStyle.medium16white,),
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

                        return null;//todo: validate

                      },
                    ),
                    SizedBox(height: height * 0.02),
                    Text('كلمه المرور',style: AppStyle.medium16white,),
                    CustomTextFormField(
                      hintText: 'كلمه المرور',
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      controller: passwordController,
                      validator: (text) {
                        if(text == null ||text.trim().isEmpty){
                          return 'please enter your password'; // todo: invalid
                        }
                        if(text.length < 6){
                          return 'minimum password length is 6';
                        }
                        return null; //todo: validate
                      },
                    ),
                    Row(
                      mainAxisAlignment: .center,
                      children: [
                        TextButton(
                          onPressed: () {
                            // todo: navigate to forget password
                            Navigator.of(context).pushNamed(AppRoutes.forgetPasswordRouteName);
                          },
                          child: Text(
                            'هل نسيت كلمه المرور؟',
                            style: AppStyle.medium16secondaryGrey
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.02),
                    CustomElevatedButton(
                      widthPadding: width*0.02,
                      mainAxisAlignment: MainAxisAlignment.center,

                      onPressed: login,
                      text: 'تسجيل الدخول',
                      textStyle: AppStyle.bold20white,
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.25),
              Row(
                mainAxisAlignment: .center,
                children: [
                  Text('لا تمتلك حساب؟',style: AppStyle.medium14darkGrey,),
                  TextButton(
                    onPressed: () {
                      //todo: navigate to register screen
                      Navigator.of(context).pushNamed(AppRoutes.registerRouteName);
                    },
                    child: Text(
                        'حساب جديد',
                        style: AppStyle.medium16secondaryGrey
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  void login() {
    if(formKey.currentState?.validate() == true){
      //todo: login
      Navigator.of(context).pushNamed(AppRoutes.homeRouteName);
    }
  }
}
