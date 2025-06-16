import 'package:doodi/constants/colors.dart';
import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.blackColor,
  appBarTheme: AppBarTheme(backgroundColor: AppColors.blackColor),
  bottomAppBarTheme: BottomAppBarTheme(color: AppColors.blackColor),
  iconTheme: IconThemeData(color: AppColors.whiteColor),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: AppColors.whiteColor),
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.whiteColor,
    brightness: Brightness.dark,
  ),
  cardColor: Color(0xFF1E1E1E),
  dividerColor: AppColors.darkModeColor,
  sliderTheme: SliderThemeData(
    thumbColor: AppColors.whiteColor,
    activeTrackColor: AppColors.whiteColor,
    inactiveTrackColor: AppColors.darkModeColor,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.darkModeColor,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 0.7, color: Colors.transparent),
      borderRadius: BorderRadius.circular(7),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 1.5, color: AppColors.whiteColor),
      borderRadius: BorderRadius.circular(7),
    ),
    hintStyle: TextStyle(color: AppColors.whiteColor),
  ),
);
