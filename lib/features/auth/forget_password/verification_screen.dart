import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

import '../../../core/themes/colors/app_colors.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/themes/styles/app_style.dart';
import '../../../core/widgets/custom_elevated_button.dart';
import '../presentation/cubit/auth_cubit.dart';
import '../presentation/cubit/auth_state.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final otpController = TextEditingController();
  int seconds = 60;
  Timer? timer;
  String? phoneNumber;
  bool isArgumentsLoaded = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer?.cancel();
    seconds = 60;
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (seconds > 0) {
        setState(() => seconds--);
      } else {
        t.cancel();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isArgumentsLoaded) {
      phoneNumber = ModalRoute.of(context)?.settings.arguments as String?;
      isArgumentsLoaded = true;
    }
  }

  @override
  void dispose() {
    otpController.dispose();
    timer?.cancel();
    super.dispose();
  }

  String formatTime() {
    int m = seconds ~/ 60;
    int s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    final defaultPinTheme = PinTheme(
      width: 55,
      height: 55,
      textStyle: AppStyle.bold20white,
      decoration: BoxDecoration(
        color: const Color(0xff222222),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.transparent),
      ),
    );
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
        border: Border.all(color: AppColors.borderSideColor));

    return BlocProvider(
      create: (_) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)));
          } else if (state is AuthVerifySuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)));
            Navigator.of(context).pushNamed(
                AppRoutes.resetPasswordRouteName, arguments: state.phone);
          } else if (state is AuthResendSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)));
            startTimer();
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
                    SizedBox(height: height * 0.01),
                    const Text('التحقق', style: AppStyle.bold24white,
                        textAlign: TextAlign.center),
                    SizedBox(height: height * 0.01),
                    Text('أدخل رمز التحقق الذي أرسلناه إليك: ${phoneNumber ??
                        ''}', style: AppStyle.medium16white,
                        textAlign: TextAlign.center),
                    SizedBox(height: height * 0.04),
                    Pinput(
                      controller: otpController,
                      length: 4,
                      keyboardType: TextInputType.number,
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: focusedPinTheme,
                    ),
                    SizedBox(height: height * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                            Icons.access_time, color: Colors.white, size: 18),
                        const SizedBox(width: 5),
                        Text(formatTime(), style: AppStyle.medium16white),
                      ],
                    ),
                    SizedBox(height: height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                            'لم تتلق الرمز؟ ', style: AppStyle.medium16white),
                        TextButton(
                          onPressed: seconds == 0 && !isLoading
                              ? () {
                            if (phoneNumber == null || phoneNumber!.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('رقم الجوال غير موجود')));
                              return;
                            }
                            context.read<AuthCubit>().resendCode(
                                phone: phoneNumber!);
                          }
                              : null,
                          child: Text('إعادة إرسال',
                              style: TextStyle(color: seconds == 0
                                  ? AppColors.primaryText
                                  : Colors.grey)),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.03),
                    isLoading
                        ? const Center(child: CircularProgressIndicator(
                        color: AppColors.primaryText))
                        : CustomElevatedButton(
                      mainAxisAlignment: MainAxisAlignment.center,
                      onPressed: () {
                        if (otpController.text.length != 4) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('يرجى إدخال رمز 4 أرقام')));
                          return;
                        }
                        if (phoneNumber == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('رقم الجوال غير موجود')));
                          return;
                        }
                        context.read<AuthCubit>().verifyCode(
                            phone: phoneNumber!,
                            code: otpController.text.trim());
                      },
                      text: 'تحقق',
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
}
