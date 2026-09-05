import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_assets.dart';
import '../../../core/themes/colors/app_colors.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/themes/styles/app_style.dart';
import '../../../core/widgets/custom_elevated_button.dart';
import '../../../core/widgets/custom_text_form_field.dart';
import '../presentation/cubit/auth_cubit.dart';
import '../presentation/cubit/auth_state.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  bool _isValidPhone(String t) {
    final v = t.trim().replaceAll(' ', '').replaceAll('-', '');
    final isSaudi = RegExp(r'^(\+966|966|0)?5\d{8}$').hasMatch(v);
    final isEgyptian = RegExp(r'^((\+20|0020)?1[0125]\d{8}|01[0125]\d{8})$')
        .hasMatch(v);
    return isSaudi || isEgyptian;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)));
          } else if (state is AuthForgetPasswordSuccess) {
            Navigator.of(context).pushNamed(
                AppRoutes.verificationPasswordRouteName,
                arguments: state.phone);
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(backgroundColor: AppColors.appBarColor),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(AppAssets.soorLogo),
                    SizedBox(height: height * 0.02),
                    const Text(
                        'هل نسيت كلمه المرور؟', style: AppStyle.bold24white,
                        textAlign: TextAlign.center),
                    SizedBox(height: height * 0.02),
                    Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text('رقم الجوال', style: AppStyle.bold16white),
                          SizedBox(height: height * 0.01),
                          CustomTextFormField(
                            hintText: '+966 500 000 000',
                            keyboardType: TextInputType.phone,
                            controller: phoneController,
                            validator: (text) {
                              if (text == null || text
                                  .trim()
                                  .isEmpty) return 'يرجى إدخال رقم الجوال';
                              if (!_isValidPhone(text))
                                return 'رقم غير صحيح (سعودي +9665... أو مصري 010...)';
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    isLoading
                        ? const Center(child: CircularProgressIndicator(
                        color: AppColors.primaryText))
                        : CustomElevatedButton(
                      widthPadding: 40,
                      mainAxisAlignment: MainAxisAlignment.center,
                      onPressed: () => _submit(context),
                      text: 'ارسال',
                      textStyle: AppStyle.bold20white,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
    );
  }

  void _submit(BuildContext context) {
    if (formKey.currentState?.validate() == true) {
      context.read<AuthCubit>().forgetPassword(
          phone: phoneController.text.trim());
    }
  }
}
