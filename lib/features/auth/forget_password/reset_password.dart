import 'package:flutter/material.dart';

import '../../../core/utils/app_assets.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/themes/styles/app_style.dart';
import '../../../core/widgets/custom_elevated_button.dart';
import '../../../core/widgets/custom_text_form_field.dart';


class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController(text: '123456');
  TextEditingController rePasswordController = TextEditingController(text: '123456');
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: .stretch,
            children: [
              Image.asset(AppAssets.soorLogo),
              SizedBox(height: height * 0.02),
              Text(
                'اعاده ضبط كلمه المرور',
                style: AppStyle.bold24white,
                textAlign: .center,
              ),
              SizedBox(height: height * 0.02),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: .stretch,
                  children: [
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
                    SizedBox(height: height * 0.01),
                    Text('تاكيد كلمه المرور',style: AppStyle.medium16white,),
                    CustomTextFormField(
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      controller: rePasswordController,
                      validator: (text) {
                        if(text == null ||text.trim().isEmpty){
                          return 'please enter your re_password'; // todo: invalid
                        }
                        if(text != passwordController.text){
                          return 'password not match'; // todo: invalid
                        }

                        return null; //todo: validate
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.02),
              CustomElevatedButton(
                mainAxisAlignment: MainAxisAlignment.center,
                onPressed: () {
                  //todo: navigate to password change
                  Navigator.of(context).pushNamed(AppRoutes.changePasswordRouteName);
                },
                text: 'حفظ',
                textStyle: AppStyle.bold20white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
