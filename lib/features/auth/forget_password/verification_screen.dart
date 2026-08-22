import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_routes.dart';
import '../../../core/utils/app_style.dart';
import '../../../core/widget/custom_elevated_button.dart';

class VerificationScreen extends StatefulWidget {
  VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final otpController = TextEditingController();

  int seconds = 60;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer?.cancel();

    seconds = 60;

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  String? phoneNumber;
  bool isArgumentsLoaded = false;

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
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;

    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
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
      border: Border.all(color: AppColors.borderSideColor),
    );

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: .stretch,
            children: [
              SizedBox(height: height * 0.01),
              Text(
                'التحقق',
                style: AppStyle.bold24white,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: height * 0.01),
              Text(
                'أدخل رمز التحقق الذي أرسلناه إليك:${phoneNumber ?? ''}',
                style: AppStyle.medium16white,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: height * 0.01),
              SizedBox(height: height * 0.04),
              Pinput(
                controller: otpController,
                length: 5,
                keyboardType: TextInputType.number,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
              ),
              SizedBox(height: height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.access_time, color: Colors.white, size: 18),
                  const SizedBox(width: 5),

                  Text(formatTime(), style: AppStyle.medium16white),
                ],
              ),
              SizedBox(height: height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('لم تتلق الرمز؟ ', style: AppStyle.medium16white),

                  TextButton(
                    onPressed: seconds == 0
                        ? () {
                            startTimer();

                            // TODO: Resend OTP
                          }
                        : null,
                    child: Text(
                      'إعادة إرسال',
                      style: TextStyle(
                        color: seconds == 0
                            ? AppColors.borderSideColor
                            : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.03),
              CustomElevatedButton(
                mainAxisAlignment: MainAxisAlignment.center,
                onPressed: () {
                  if (otpController.text.length == 5) {
                    // TODO: Navigate To Reset Password
                    Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.resetPasswordRouteName, (route) => false,);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('يرجى إدخال رمز التحقق كاملاً'),
                      ),
                    );
                  }
                },
                text: 'تحقق',
                textStyle: AppStyle.bold20white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
