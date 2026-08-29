import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/app_assets.dart';
import '../../core/themes/colors/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../core/themes/styles/app_style.dart';
import '../../core/widgets/custom_elevated_button.dart';
import '../../core/widgets/custom_text_form_field.dart';
import '../../l10n/app_localizations.dart';
import 'presentation/cubit/auth_cubit.dart';
import 'presentation/cubit/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController(text: '+966500000000');
  final passwordController = TextEditingController(text: 'password123');

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool _isSaudiPhone(String text) {
    final v = text.trim();
    // accepts +9665xxxxxxxx, 9665xxxxxxxx, 05xxxxxxxx, 5xxxxxxxx
    return RegExp(r'^(\+966|966|0)?5\d{8}$').hasMatch(v);
  }

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
          } else if (state is AuthLoginSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
                state.response.message ?? 'تم تسجيل الدخول بنجاح')));
            Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.homeRouteName, (r) => false);
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: AppColors.appBarColor,
              title: Row(
                children: [
                  Image.asset(AppAssets.languageIcon),
                  SizedBox(width: width * 0.01),
                  Text('English', style: AppStyle.medium16primary),
                ],
              ),
              actions: [
                const Icon(Icons.close, color: Colors.white),
                SizedBox(width: width * 0.02),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset(AppAssets.soorLogo),
                    SizedBox(height: height * 0.04),
                    Text(AppLocalizations.of(context)!.welcome,
                        style: AppStyle.bold24white),
                    const Text(
                        'مع سور ... انت فى السيلم ، قم بتسجيل الدخول الآن',
                        style: AppStyle.medium16white),
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
                                return 'رقم جوال غير صحيح (مثال +966500000000)';
                              return null;
                            },
                          ),
                          SizedBox(height: height * 0.02),
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
                              if (text.length < 6)
                                return 'كلمة المرور 6 أحرف على الأقل';
                              return null;
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pushNamed(
                                        AppRoutes.forgetPasswordRouteName),
                                child: const Text('هل نسيت كلمه المرور؟',
                                    style: AppStyle.medium16secondaryGrey),
                              ),
                            ],
                          ),
                          SizedBox(height: height * 0.02),
                          isLoading
                              ? const Center(child: CircularProgressIndicator(
                              color: AppColors.primaryText))
                              : CustomElevatedButton(
                            widthPadding: width * 0.02,
                            mainAxisAlignment: MainAxisAlignment.center,
                            onPressed: () => _login(context),
                            text: 'تسجيل الدخول',
                            textStyle: AppStyle.bold20white,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                            'لا تمتلك حساب؟', style: AppStyle.medium14darkGrey),
                        TextButton(
                          onPressed: () =>
                              Navigator.of(context).pushNamed(
                                  AppRoutes.registerRouteName),
                          child: const Text('حساب جديد',
                              style: AppStyle.medium16secondaryGrey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _login(BuildContext context) {
    if (formKey.currentState?.validate() == true) {
      context.read<AuthCubit>().login(phone: phoneController.text.trim(),
          password: passwordController.text);
    }
  }
}
