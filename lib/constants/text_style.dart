import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class AppTextStyles extends GetxController {
  static RxDouble scale = 1.0.obs; // 변경값을 화면에 바로 표시하기 위해 Rx 변수 - Obx 활용
  late Box box;

  // scale 값 변경 함수.
  // scale 변수와 text style들이 static 값이기 때문에 변경이 어려워 함수를 통해 변경하는 방식.
  void changeScale(double n) {
    scale.value = n;
  }

  // slider 상태 표시용. Settings.dart 내 updateTextScale 함수의 num값과 동일한 값이어야 함.
  // scale 값을 통해 slider의 인덱스 값 return.
  double getScale() {
    if ((scale.value - 0.9).abs() < 0.01) return 0;
    if ((scale.value - 1.0).abs() < 0.01) return 1;
    if ((scale.value - 1.2).abs() < 0.01) return 2;
    return 1;
  }

  // 설정된 텍스트 크기 hive 저장용. scale 값이 저장됨(ex. 0.9)
  @override
  void onInit() {
    super.onInit();
    box = Hive.box('settings');
    loadScale(); // 앱 시작 시 자동 호출
  }

  // 저장된 scale값으로 현재 scale값 변경
  void loadScale() {
    changeScale(box.get('scale', defaultValue: 1.0));
  }

  // 변경된 scale값 저장
  void handleScale(double value) {
    box.put('scale', value);
  }

  // 지정한 스타일. 텍스트 위젯에 사용
  // getter -> 호출될 때마다 실행, 순간의 값을 계산하여 반환
  static TextStyle get gameTitle =>
      TextStyle(fontSize: 15 * scale.value, fontFamily: 'ria-r');

  static TextStyle get pageTitle =>
      TextStyle(fontSize: 17 * scale.value, fontFamily: 'ria-r');

  static TextStyle get free25 =>
      TextStyle(fontSize: 25 * scale.value, fontFamily: 'free-7');

  static TextStyle get boldFree15 =>
      TextStyle(fontSize: 15 * scale.value, fontFamily: 'free-7');

  static TextStyle get free17 =>
      TextStyle(fontSize: 17 * scale.value, fontFamily: 'free-4');

  static TextStyle get free15 =>
      TextStyle(fontSize: 15 * scale.value, fontFamily: 'free-4');

  static TextStyle get free13 =>
      TextStyle(fontSize: 13 * scale.value, fontFamily: 'free-4');

  static TextStyle get free12 =>
      TextStyle(fontSize: 12 * scale.value, fontFamily: 'free-4');

  static TextStyle get free10 =>
      TextStyle(fontSize: 10 * scale.value, fontFamily: 'free-4');

  static TextStyle get lightFree15 =>
      TextStyle(fontSize: 15 * scale.value, fontFamily: 'free-2');

  static TextStyle get lightFree12 =>
      TextStyle(fontSize: 12 * scale.value, fontFamily: 'free-2');

  static TextStyle get lightFree10 =>
      TextStyle(fontSize: 10 * scale.value, fontFamily: 'free-2');
}
