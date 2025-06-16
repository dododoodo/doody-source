import 'package:get/get.dart';
import 'package:hive/hive.dart';

class SplashController extends GetxController {
  // .obs를 통해 반응형 변수로 변경
  var showSplash = true.obs;
  late Box box;

  @override
  void onInit() {
    super.onInit();
    box = Hive.box('splash');
    checkVisited(); // 앱 시작 시 자동 호출
  }

  // 저장된 값을 통해 splash 노출 판단
  Future<void> checkVisited() async {
    // 방문했을 경우 false
    if (box.get('visited') == true) {
      showSplash.value = false;
    } else {
      // 첫 방문일 경우 2초 후 splash 끄고 hive에 기록.
      await Future.delayed(Duration(seconds: 2));
      box.put('visited', true);
      showSplash.value = false;
    }
  }
}
