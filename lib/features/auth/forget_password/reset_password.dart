import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_assets.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/themes/styles/app_style.dart';
import '../../../core/widgets/custom_elevated_button.dart';
import '../../../core/widgets/custom_text_form_field.dart';
import '../presentation/cubit/auth_cubit.dart';
import '../presentation/cubit/auth_state.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController(text: '');
  final rePasswordController = TextEditingController(text: '');
  String? phoneNumber;
  bool loaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!loaded) {
      phoneNumber = ModalRoute
          .of(context)
          ?.settings
          .arguments as String?;
      loaded = true;
    }
  }

  @override
  void dispose() {
    passwordController.dispose();
    rePasswordController.dispose();
    super.dispose();
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
          } else if (state is AuthResetPasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)));
            Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.changePasswordRouteName, (r) => false);
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(AppAssets.soorLogo),
                    SizedBox(height: height * 0.02),
                    const Text(
                        'اعاده ضبط كلمه المرور', style: AppStyle.bold24white,
                        textAlign: TextAlign.center),
                    if (phoneNumber != null) ...[
                      SizedBox(height: height * 0.01),
                      Text(phoneNumber!, style: AppStyle.medium16secondaryGrey,
                          textAlign: TextAlign.center),
                    ],
                    SizedBox(height: height * 0.02),
                    Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
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
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    isLoading
                        ? const Center(
                        child: CircularProgressIndicator(color: Color(
                            0xffC89100)))
                        : CustomElevatedButton(
                      mainAxisAlignment: MainAxisAlignment.center,
                      onPressed: () => _submit(context),
                      text: 'حفظ',
                      textStyle: AppStyle.bold20white,
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

  void _submit(BuildContext context) {
    if (formKey.currentState?.validate() != true) return;
    if (phoneNumber == null || phoneNumber!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('رقم الجوال غير موجود، ارجع للخطوة السابقة')));
      return;
    }
    context.read<AuthCubit>().resetPassword(
      phone: phoneNumber!,
      password: passwordController.text,
      confirm: rePasswordController.text,
    );
  }
}
