import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';
import 'package:doodi/constants/text_style.dart';
import 'package:doodi/constants/colors.dart';
import 'package:doodi/controller/theme_controller.dart';
import 'package:doodi/controller/splash_controller.dart';
import 'package:doodi/screen/Home.dart';
import 'package:doodi/screen/NewPost.dart';
import 'package:doodi/screen/Settings.dart';
import 'package:doodi/screen/splash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // hive 비동기 처리

  await Hive.initFlutter(); // hive 초기화
  await Hive.openBox('settings');
  await Hive.openBox('splash');
  await Hive.openBox('votes');
  await Hive.openBox('like_dislike');

  // 전역 state 사용 준비
  final themeController = Get.put(ThemeController());
  Get.put(AppTextStyles());
  Get.put(SplashController());
  themeController.loadTheme();
  await dotenv.load();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final splashController = Get.find<SplashController>();

    return Obx(() {
      return GetMaterialApp(
        title: 'doody',
        theme: themeController.theme.value, // default: Light Theme
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        home: splashController.showSplash.value
            ? SplashScreen()
            : MyHomePage(title: '두디-Doody'),
      );
    });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});
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

  List<Widget> get pageList => [
    Home(),
    NewPost(changeIndex: changeIndex),
    Settings(),
  ];

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
