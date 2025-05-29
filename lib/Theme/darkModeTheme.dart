import 'package:flutter/material.dart';
import 'package:projek/Theme/appColors.dart';

// Stel die tema van die projek hier 
// Sekere velde word "implicityly" gedoen bv. bottomNavigationBarTheme
// Anders stel ek dit hadmatig met : Theme.of(context).primaryColor
ThemeData darkMode = ThemeData(
        primaryColor: AppColors.lavender,
        primaryColorDark: AppColors.lavender,
        primaryColorLight: AppColors.darkGrey,
        scaffoldBackgroundColor: AppColors.darkGrey,

        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.darkGrey,
          foregroundColor: Colors.white,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.darkGrey,
          selectedItemColor: AppColors.white,
          unselectedItemColor: AppColors.lightGrey,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: AppColors.lavender),
          displayMedium: TextStyle(color: AppColors.lavender),
          displaySmall: TextStyle(color: AppColors.lavender),
          headlineLarge: TextStyle(color: AppColors.lavender),
          headlineMedium: TextStyle(color: AppColors.lavender),
          headlineSmall: TextStyle(color: AppColors.lavender),
          titleLarge: TextStyle(color: AppColors.lavender),
          titleMedium: TextStyle(color: AppColors.lavender),
          titleSmall: TextStyle(color: AppColors.lavender , fontWeight: FontWeight.bold),

          // Body text + labels in slate
          bodyLarge: TextStyle(color: AppColors.white),
          bodyMedium: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.white ),
          labelLarge: TextStyle(color: AppColors.white),
          labelMedium: TextStyle(color: AppColors.white),
          labelSmall: TextStyle(color: AppColors.white),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: AppColors.lavender,
        )
      );