import 'package:doodi/constants/colors.dart';
import 'package:doodi/constants/text_style.dart';
import 'package:doodi/controller/theme_controller.dart';
import 'package:doodi/widget/fontSize_slider.dart';
import 'package:flutter/material.dart';
import 'package:doodi/widget/theme_toggle.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Settings> {
  final controller = Get.find<ThemeController>(); // 테마 변경용 컨트롤러
  final controller2 = Get.find<AppTextStyles>(); // 텍스트 사이즈 변경용 컨트롤러

  // scale 값 변경 함수
  void updateTextScale(double idx) {
    setState(() {
      late double num;
      switch (idx) {
        case 0:
          num = 0.9;
          break;
        case 1:
          num = 1.0;
          break;
        case 2:
          num = 1.2;
          break;
        default:
          AppTextStyles.scale.value = 1.0;
      }

      // 각 인덱스 값에 따라 scal값 변경 후 컨트롤러 내 함수를 통해 hive 저장.
      AppTextStyles.scale.value = num;
      controller2.handleScale(num);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> menu = [
      {
        "icon": Symbols.settings_night_sight,
        "title": '화면 모드',
        "content": Obx(
          () => ThemeToggle(
            themeIdx: controller.themeIdx.value,
            onToggle: (idx) {
              controller.handleTheme(idx); // 선택된 인덱스에 따라 테마 적용
            },
          ),
        ),
      },
      {
        "icon": Icons.text_fields,
        "title": '텍스트 크기',
        "content": FontSizeSlider(
          onChanged: (idx) {
            updateTextScale(idx);
          },
        ),
      },
      {
        "icon": Icons.info_outline_rounded,
        "title": '앱 정보',
        "content": Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '두디 Dood - 밸런스 게임 커뮤니티 어플리케이션\n버전 1.0.0\n개발자 dododoodo, Jiho8\nⓒ 2025. dododoodo / Jiho8 All rights reserved.',
              style: AppTextStyles.lightFree12.copyWith(
                color: controller.themeIdx == 0
                    ? AppColors.greyColor
                    : AppColors.whiteColor,
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
          child: Text('나만의 스타일로\n어플을 설정하세요!', style: AppTextStyles.pageTitle),
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
                    Icon(
                      item['icon'],
                      color: Theme.of(context).iconTheme.color,
                    ),
                    SizedBox(width: 7),
                    Text(item['title'], style: AppTextStyles.free15),
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
