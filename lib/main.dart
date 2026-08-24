import 'package:flutter/material.dart';
import 'package:soor_user_app/features/home/booking_details/booking_details_screen.dart';
import 'package:soor_user_app/features/home/tabs/service/google_map/google_maps_screen.dart';

import 'core/routes/app_routes.dart';
import 'core/themes/theme/app_theme.dart';
import 'features/auth/forget_password/forget_password.dart';
import 'features/auth/forget_password/password_change.dart';
import 'features/auth/forget_password/reset_password.dart';
import 'features/auth/forget_password/verification_screen.dart';
import 'features/auth/login_screen.dart';
import 'features/auth/register_screen.dart';
import 'features/auth/success_screen.dart';
import 'features/home/chat/chat_screen.dart';
import 'features/home/home_screen.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      locale: Locale('ar'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme,
      home: GoogleMapsScreen(),
      // initialRoute: AppRoutes.homeRouteName,
      // routes: {
      //   AppRoutes.loginRouteName: (context) => const LoginScreen(),
      //   AppRoutes.registerRouteName: (context) => const RegisterScreen(),
      //   AppRoutes.homeRouteName: (context) => const HomeScreen(),
      //   AppRoutes.successRouteName: (context) => const SuccessScreen(),
      //   AppRoutes.forgetPasswordRouteName: (context) => const ForgetPassword(),
      //   AppRoutes.resetPasswordRouteName: (context) => const ResetPassword(),
      //   AppRoutes.changePasswordRouteName: (context) => const PasswordChange(),
      //   AppRoutes.verificationPasswordRouteName: (context) =>
      //       VerificationScreen(),
      //   AppRoutes.chatRouteName: (context) => ChatScreen(),
      // },
    );
  }
}
