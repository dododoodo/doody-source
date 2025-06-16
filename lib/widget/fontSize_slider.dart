import 'package:doodi/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FontSizeSlider extends StatefulWidget {
  final Function(double) onChanged; // 설정 페이지로부터 받은 콜백함수. slider 값이 변경되면 실행.

  const FontSizeSlider({super.key, required this.onChanged});

  @override
  State<FontSizeSlider> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<FontSizeSlider> {
  final controller = Get.find<AppTextStyles>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 12),
            ),
            child: Slider(
              min: 0,
              max: 2,
              divisions: 2, // 단계 설정 (0, 1, 2 세 단계)
              value: controller.getScale(), // scale 값에 따라 인덱스값 반환하는 getScale 함수
              onChanged: (idx) {
                widget.onChanged(idx.roundToDouble());
              },
            ),
          ),

          // 슬라이더 아래 라벨
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('작게', style: AppTextStyles.free12),
                Text('보통', style: AppTextStyles.free15),
                Text('크게', style: AppTextStyles.free17),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
