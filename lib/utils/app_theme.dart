import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_style.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
      focusColor: Colors.white,
      dividerColor: Colors.white,
      highlightColor: Colors.grey,
      splashColor: Colors.grey,
      cardColor: Colors.black,
      primaryColor: AppColors.primaryLight,
      scaffoldBackgroundColor: AppColors.whiteBgColor,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
            color: AppColors.primaryLight
        ),
      ),
      textTheme: TextTheme(
          headlineLarge: AppStyle.bold20black,
          headlineMedium: AppStyle.medium16primary,
          headlineSmall: AppStyle.bold16black,
          titleMedium: AppStyle.medium16white,
          titleSmall: AppStyle.medium16black,
          bodyLarge: AppStyle.medium16grey
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.primaryLight,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        selectedLabelStyle: AppStyle.bold12white,
        unselectedLabelStyle: AppStyle.bold12white,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryLight,
        shape: StadiumBorder(
            side: BorderSide(
                width: 6,
                color: Colors.white
            )
        ),
      )

  );

}