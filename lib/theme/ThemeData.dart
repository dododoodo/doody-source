import 'package:flutter/material.dart';

// 라이트 모드
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'free-4',
  scaffoldBackgroundColor: Color.fromARGB(255, 251, 251, 251), // 전체 배경색
  appBarTheme: AppBarTheme(backgroundColor: Color.fromARGB(255, 251, 251, 251)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color.fromARGB(255, 251, 251, 251),
    selectedItemColor: Color.fromARGB(255, 92, 92, 92),
    unselectedItemColor: Color.fromARGB(255, 229, 231, 235),
  ),
  textTheme: TextTheme(
    bodyMedium: TextStyle(color: Color.fromARGB(255, 28, 35, 49)),

    // body 본문 텍스트: bodyLarge, bodyMedium, bodySmall
    // label 텍스트:    labelLarge, labelMedium labelSmall
    // headline 텍스트: headlineLarge headlineMedium headlineSmall
  ),
);

// 다크 모드
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'free-4',
  scaffoldBackgroundColor: Color.fromARGB(255, 28, 35, 49), // 전체 배경색
  appBarTheme: AppBarTheme(backgroundColor: Color.fromARGB(255, 28, 35, 49)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color.fromARGB(255, 28, 35, 49),
    selectedItemColor: Color.fromARGB(255, 251, 251, 251),
    unselectedItemColor: Color.fromARGB(125, 251, 251, 251),
  ),
  textTheme: TextTheme(
    bodyMedium: TextStyle(color: Color.fromARGB(255, 251, 251, 251)),
  ),
);
