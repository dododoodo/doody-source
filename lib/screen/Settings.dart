import 'package:doodi/widget/Settings_fontSizeSlider.dart';
import 'package:flutter/material.dart';
import 'package:doodi/widget/Settings_themeToggle.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Settings> {
  int themeIdx = 0; // 화면 모드 상태 변수 (0: 라이트모드 1: 다크)
  double fontSizeState = 1.0; // 텍스트 사이즈 상태 변수 (0, 1, 2)

  // 토글 관리 함수 (테마 변경용)
  void handleToggle(int idx) {
    setState(() {
      themeIdx = idx;
      print('테마 변경: ${idx == 1 ? "다크 모드" : "라이트 모드"}');
    });
  }

  // 슬라이더 관리 함수 (폰트 사이즈 변경용)
  void handleSlider(double state) {
    setState(() {
      fontSizeState = state;
      print('크기 변경: $state');
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> menu = [
      {
        "icon": Symbols.settings_night_sight,
        "title": '화면 모드',
        "content": ThemeToggle(themeIdx: themeIdx, onToggle: handleToggle),
      },
      {
        "icon": Icons.text_fields,
        "title": '텍스트 크기',
        "content": FontSizeSlider(
          fontSizeState: fontSizeState,
          onChanged: handleSlider,
        ),
      },
      {
        "icon": Icons.info_outline_rounded,
        "title": '앱 정보',
        "content": Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              '두디 Doodi - 밸런스 게임 커뮤니티 어플리케이션\n버전 1.0.0\n개발자 dododoodo, Jiho8\nⓒ 2025. dododoodo / Jiho8 All rights reserved.',
              style: TextStyle(
                fontFamily: 'free-2',
                color: Color.fromARGB(255, 118, 118, 118),
              ),
            ),
          ],
        ),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 20, bottom: 24),
          child: Text(
            '나만의 스타일로\n어플을 설정하세요!',
            style: TextStyle(fontFamily: 'ria-r', fontSize: 17),
          ),
        ),

        ListView.builder(
          physics: NeverScrollableScrollPhysics(), // 사용자 스크롤 막기
          shrinkWrap: true, // 자식 아이템 크기만큼만 공간 차지
          itemCount: menu.length,
          itemBuilder: (context, idx) {
            final item = menu[idx];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 아이콘 + 타이틀
                Row(
                  children: [
                    Icon(item['icon']),
                    SizedBox(width: 7),
                    Text(item['title'], style: TextStyle(fontSize: 15)),
                  ],
                ),
                SizedBox(height: 10),

                // 위젯 등 내용
                item['content'],
                SizedBox(height: 35),
              ],
            );
          },
        ),
      ],
    );
  }
}
