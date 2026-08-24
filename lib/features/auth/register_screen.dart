import 'package:flutter/material.dart';

import '../../core/utils/app_assets.dart';
import '../../core/routes/app_routes.dart';
import '../../core/themes/styles/app_style.dart';
import '../../core/widgets/custom_elevated_button.dart';
import '../../core/widgets/custom_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  bool checkBoxValue = false;

  TextEditingController namedController = TextEditingController(text: 'mohamed');

  TextEditingController emailController = TextEditingController(text: 'mohamed@gmail.com');
  TextEditingController phoneController = TextEditingController(text: '01014603733');

  TextEditingController passwordController = TextEditingController(text: '123456');

  TextEditingController rePasswordController = TextEditingController(text: '123456');
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.black,
      body:  SafeArea(
        child:  Padding(
          padding: EdgeInsets.symmetric(vertical: height*0.04, horizontal: width*0.04),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(AppAssets.soorLogo),
                SizedBox(height: height*0.02,),
                Text('إنشاء حساب!',style: AppStyle.bold24white,),
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
                      SizedBox(height: height * 0.01),
                      Text('البريد الالكتروني',style: AppStyle.medium16white,),
                      CustomTextFormField(
                        hintText: 'ادخل البريد الالكتروني',
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        validator: (text) {
                          if(text == null ||text.trim().isEmpty){
                            return 'please enter your email'; // todo: invalid
                          }
                          final bool emailValid = RegExp( r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$', ).hasMatch(text);
                          if(!emailValid){
                            return 'please enter a valid email';
                          }
                          return null; //todo: validate

                        },
                      ),
                      SizedBox(height: height * 0.01),
                      Text('الاسم كامل',style: AppStyle.medium16white,),
                      CustomTextFormField(
                        keyboardType: TextInputType.name,
                        controller: namedController,
                        validator: (text) {
                          if(text == null ||text.trim().isEmpty){
                            return 'please enter your name'; // todo: invalid
                          }
                          return null; //todo: validate

                        },
                      ),
                      SizedBox(height: height * 0.01),
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
                      SizedBox(height: height * 0.02),
                      CustomElevatedButton(
                        widthPadding: width*0.02,
                        mainAxisAlignment: MainAxisAlignment.center,
                        onPressed: register,
                        text: 'تسجيل حساب',
                        textStyle: AppStyle.bold20white,
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: checkBoxValue,
                            onChanged: (v) {
                              checkBoxValue = v!;
                              setState(() {

                              });
                            },
                          ),
                          Text('اوافق علي شروط الخدمه و',style: AppStyle.medium16white,),
                          Text('سياسة الخصوصيه',style: AppStyle.medium16secondaryGrey,),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: .center,
                        children: [
                          Text('هل تمتلك حساب بالفعل؟',style: AppStyle.medium14darkGrey,),
                          TextButton(
                            onPressed: () {
                              //todo: navigate to register screen
                              Navigator.pop(context);
                            },
                            child: Text(
                                'تسجيل دخول',
                                style: AppStyle.medium16secondaryGrey
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void register() {
    if(formKey.currentState?.validate() == true){
      if(!checkBoxValue){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('يجب الموافقه علي شروط الخدمه'))
        );
        return;
      }
      //todo: register
      Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.successRouteName, (route) => false,);
    }
  }
}
