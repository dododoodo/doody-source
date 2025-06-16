import 'package:doodi/constants/colors.dart';
import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.whiteColor,
  appBarTheme: AppBarTheme(backgroundColor: AppColors.whiteColor),
  bottomAppBarTheme: BottomAppBarTheme(color: AppColors.whiteColor),
  iconTheme: IconThemeData(color: AppColors.blackColor),
  fontFamily: 'free-4',
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: AppColors.blackColor),
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.blackColor,
    brightness: Brightness.light,
  ),
  cardColor: AppColors.whiteColor,
  dividerColor: AppColors.lineColor,
  sliderTheme: SliderThemeData(
    thumbColor: AppColors.blackColor,
    activeTrackColor: AppColors.blackColor,
    inactiveTrackColor: AppColors.lineColor,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: false,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 0.7, color: AppColors.greyColor),
      borderRadius: BorderRadius.circular(7),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 1.5, color: AppColors.pointBlue),
      borderRadius: BorderRadius.circular(7),
    ),
    hintStyle: TextStyle(color: AppColors.greyColor),
  ),
);
