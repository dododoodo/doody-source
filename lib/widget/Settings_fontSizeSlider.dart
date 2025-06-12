import 'package:flutter/material.dart';

class FontSizeSlider extends StatelessWidget {
  final double fontSizeState;
  final ValueChanged<double> onChanged;

  const FontSizeSlider({
    Key? key,
    required this.fontSizeState,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 12),
            thumbColor: Color.fromARGB(255, 28, 35, 49),
            activeTrackColor: Color.fromARGB(255, 28, 35, 49),
            inactiveTrackColor: Color.fromARGB(255, 229, 231, 235),
          ),
          child: Slider(
            min: 0,
            max: 2,
            divisions: 2, // 단계 설정 (0, 1, 2 세 단계)
            value: fontSizeState,
            onChanged: (idx) {
              onChanged(idx);
            },
          ),
        ),

        // 슬라이더 아래 라벨
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('작게', style: TextStyle(fontSize: 12)),
              Text('보통', style: TextStyle(fontSize: 14)),
              Text('크게', style: TextStyle(fontSize: 17)),
            ],
          ),
        ),
      ],
    );
  }
}
