import 'package:doodi/theme/light_theme.dart';
import 'package:doodi/theme/dark_theme.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class ThemeController extends GetxController {
  // .obs를 통해 반응형 변수로 변경
  final themeIdx = 0.obs; // 현재 선택된 테마의 인덱스 값 (0: 라이트, 1: 다크)
  final theme = lightTheme.obs; //
  late Box box;

  @override
  void onInit() {
    super.onInit();
    box = Hive.box('settings');
    loadTheme(); // 앱 시작 시 자동 호출
  }

  // 저장된 테마 불러오기
  void loadTheme() {
    final savedIdx = box.get(
      'themeIdx',
      defaultValue: 0,
    ); // 저장된 게 없으면 라이트(기본) 적용
    handleTheme(savedIdx);
  }

  // 테마 적용 및 저장. 인덱스 값이 바뀌면 호출
  void handleTheme(int idx) {
    themeIdx.value = idx;
    theme.value = (idx == 0) ? lightTheme : darkTheme;

    box.put('themeIdx', idx);
  }
}
