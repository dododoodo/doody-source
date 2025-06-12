import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ThemeToggle extends StatelessWidget {
  final int themeIdx; // 테마 상태 변수 (0: 라이트, 1: 다크)
  final ValueChanged<int> onToggle;

  const ThemeToggle({
    Key? key,
    required this.themeIdx, // 필수
    required this.onToggle, // 필수
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ToggleSwitch(
      minWidth: 130.0,
      cornerRadius: 30.0,
      activeBgColors: [
        [Color.fromARGB(255, 28, 35, 49)],
        [Color.fromARGB(255, 28, 35, 49)],
      ],
      activeFgColor: Color.fromARGB(255, 251, 251, 251),
      inactiveBgColor: Color.fromARGB(255, 229, 231, 235),
      inactiveFgColor: Color.fromARGB(255, 28, 35, 49),
      initialLabelIndex: themeIdx,
      totalSwitches: 2,
      labels: ['라이트 모드', '다크 모드'],
      icons: [Icons.light_mode_outlined, Icons.dark_mode_outlined],
      radiusStyle: true,
      onToggle: (idx) {
        if (idx != null) {
          onToggle(idx); // null 아닌 경우에만 전달
        }
      },
    );
  }
}
