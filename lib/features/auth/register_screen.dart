import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/app_assets.dart';
import '../../core/routes/app_routes.dart';
import '../../core/themes/styles/app_style.dart';
import '../../core/widgets/custom_elevated_button.dart';
import '../../core/widgets/custom_text_form_field.dart';
import 'presentation/cubit/auth_cubit.dart';
import 'presentation/cubit/auth_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  bool checkBoxValue = false;

  final namedController = TextEditingController(text: 'Mohamed Nasr');
  final emailController = TextEditingController(text: 'Mohamed@example.com');
  final phoneController = TextEditingController(text: '+966500000000');
  final passwordController = TextEditingController(text: 'password123');
  final rePasswordController = TextEditingController(text: 'password123');

  @override
  void dispose() {
    namedController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    super.dispose();
  }

  bool _isSaudiPhone(String text) =>
      RegExp(r'^(\+966|966|0)?5\d{8}$').hasMatch(text.trim());

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (_) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)));
          } else if (state is AuthRegisterSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.response.message ?? 'تم إنشاء الحساب')));
            Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.successRouteName, (route) => false);
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;
          return Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: height * 0.04, horizontal: width * 0.04),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.asset(AppAssets.soorLogo),
                      SizedBox(height: height * 0.02),
                      const Text('إنشاء حساب!', style: AppStyle.bold24white),
                      SizedBox(height: height * 0.02),
                      Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                                'رقم الجوال', style: AppStyle.medium16white),
                            CustomTextFormField(
                              hintText: '+966 500 000 000',
                              keyboardType: TextInputType.phone,
                              controller: phoneController,
                              validator: (text) {
                                if (text == null || text
                                    .trim()
                                    .isEmpty) return 'يرجى إدخال رقم الجوال';
                                if (!_isSaudiPhone(text))
                                  return 'رقم جوال غير صحيح';
                                return null;
                              },
                            ),
                            SizedBox(height: height * 0.01),
                            const Text('البريد الالكتروني',
                                style: AppStyle.medium16white),
                            CustomTextFormField(
                              hintText: 'ادخل البريد الالكتروني',
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              validator: (text) {
                                if (text == null || text
                                    .trim()
                                    .isEmpty) return 'يرجى إدخال البريد';
                                final ok = RegExp(
                                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                                    .hasMatch(text);
                                if (!ok) return 'بريد إلكتروني غير صحيح';
                                return null;
                              },
                            ),
                            SizedBox(height: height * 0.01),
                            const Text(
                                'الاسم كامل', style: AppStyle.medium16white),
                            CustomTextFormField(
                              keyboardType: TextInputType.name,
                              controller: namedController,
                              validator: (text) =>
                              (text == null || text
                                  .trim()
                                  .isEmpty) ? 'يرجى إدخال الاسم' : null,
                            ),
                            SizedBox(height: height * 0.01),
                            const Text(
                                'كلمه المرور', style: AppStyle.medium16white),
                            CustomTextFormField(
                              hintText: 'كلمه المرور',
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              controller: passwordController,
                              validator: (text) {
                                if (text == null || text
                                    .trim()
                                    .isEmpty) return 'يرجى إدخال كلمة المرور';
                                if (text.length < 6) return '6 أحرف على الأقل';
                                return null;
                              },
                            ),
                            SizedBox(height: height * 0.01),
                            const Text('تاكيد كلمه المرور',
                                style: AppStyle.medium16white),
                            CustomTextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              controller: rePasswordController,
                              validator: (text) {
                                if (text == null || text
                                    .trim()
                                    .isEmpty) return 'يرجى تأكيد كلمة المرور';
                                if (text != passwordController.text)
                                  return 'كلمة المرور غير متطابقة';
                                return null;
                              },
                            ),
                            SizedBox(height: height * 0.02),
                            isLoading
                                ? const Center(child: CircularProgressIndicator(
                                color: Color(0xffC89100)))
                                : CustomElevatedButton(
                              widthPadding: width * 0.02,
                              mainAxisAlignment: MainAxisAlignment.center,
                              onPressed: () => _register(context),
                              text: 'تسجيل حساب',
                              textStyle: AppStyle.bold20white,
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: checkBoxValue,
                                  onChanged: (v) =>
                                      setState(() => checkBoxValue = v!),
                                  activeColor: const Color(0xffC89100),
                                ),
                                const Text('اوافق علي شروط الخدمه و',
                                    style: AppStyle.medium16white),
                                const Text('سياسة الخصوصيه',
                                    style: AppStyle.medium16secondaryGrey),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('هل تمتلك حساب بالفعل؟',
                                    style: AppStyle.medium14darkGrey),
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('تسجيل دخول',
                                      style: AppStyle.medium16secondaryGrey),
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
        },
      ),
    );
  }

  void _register(BuildContext context) {
    if (formKey.currentState?.validate() != true) return;
    if (!checkBoxValue) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('يجب الموافقه علي شروط الخدمه')));
      return;
    }
    context.read<AuthCubit>().register(
      name: namedController.text.trim(),
      phone: phoneController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text,
      passwordConfirmation: rePasswordController.text,
    );
  }
}
