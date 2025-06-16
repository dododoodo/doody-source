import 'package:doodi/constants/colors.dart';
import 'package:doodi/constants/text_style.dart';
import 'package:doodi/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ThemeToggle extends StatelessWidget {
  final int themeIdx; // 테마 상태 변수 (0: 라이트, 1: 다크)
  final Function(int) onToggle; // 설정 페이지로부터 받은 콜백함수. 토글 시 실행.

  const ThemeToggle({
    Key? key,
    required this.themeIdx, // 필수
    required this.onToggle, // 필수
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ThemeController>(); // 테마 컨트롤러 호출

    return ToggleSwitch(
      minWidth: 130.0,
      cornerRadius: 30.0,
      // 테마에 따른 컬러 설정
      activeBgColors: [
        [AppColors.blackColor],
        [AppColors.whiteColor],
      ],
      activeFgColor: controller.themeIdx == 0
          ? AppColors.whiteColor
          : AppColors.blackColor,
      inactiveBgColor: controller.themeIdx == 0
          ? AppColors.lineColor
          : AppColors.darkModeColor,
      inactiveFgColor: controller.themeIdx == 0
          ? AppColors.blackColor
          : AppColors.whiteColor,
      initialLabelIndex: themeIdx,
      totalSwitches: 2,
      labels: ['라이트 모드', '다크 모드'],
      icons: [Icons.light_mode_outlined, Icons.dark_mode_outlined],
      radiusStyle: true,
      customTextStyles: [AppTextStyles.free15],
      onToggle: (idx) {
        if (idx != null) {
          onToggle(idx); // null 아닌 경우에만 전달
        }
      },
    );
  }
}
