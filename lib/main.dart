// import 'package:doodi/screen/NewPost.dart';
import 'package:doodi/screen/Home.dart';
import 'package:doodi/screen/NewPost.dart';
import 'package:doodi/screen/Settings.dart';
import 'package:flutter/material.dart';
import 'package:doodi/constants/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'doody',

      // Light Theme (default)
      theme: ThemeData(
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
      ),

      // Dark Theme
      darkTheme: ThemeData(
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
      ),

      themeMode: ThemeMode.system,
      home: const MyHomePage(title: '두디-Doody'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int pageIndex = 0;
  int navIndex = 0;

  void changeIndex(int idx) {
    setState(() {
      pageIndex = idx;
    });
  }

  List<Widget> get pageList => [Home(), NewPost(), Settings()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset('assets/imgs/main_logo_01.svg'),
              SvgPicture.asset('assets/imgs/main_logo_02.svg'),
            ],
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: pageList[pageIndex],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: navIndex,

        selectedItemColor: Theme.of(context).iconTheme.color,
        unselectedItemColor: Theme.of(context).brightness == Brightness.dark
            ? const Color.fromRGBO(255, 255, 255, 0.5)
            : const Color.fromRGBO(18, 18, 18, 0.5),

        onTap: (index) {
          setState(() {
            navIndex = index;
            pageIndex = index;
          });
        },

        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 27), label: '홈'),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(6),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.pointBlue,
                ),
                padding: const EdgeInsets.all(16),
                child: Icon(Icons.add, color: Colors.white),
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, size: 27),
            label: '설정',
          ),
        ],
      ),
    );
  }
}
