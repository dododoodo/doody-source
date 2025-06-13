import 'package:flutter/material.dart';
import 'package:doodi/constants/colors.dart';
import 'package:doodi/constants/text_style.dart';

class SearchField extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const SearchField({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 35,
      child: TextField(
        cursorColor: const Color(0xff7f7f7f),
        style: AppTextStyles.free12.copyWith(
          color: Theme.of(context).textTheme.bodyMedium?.color,
        ),
        onChanged: onChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).cardColor,
          hintText: '원하는 밸런스 게임을 검색해보세요!',
          hintStyle: AppTextStyles.free12,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 15,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Theme.of(context).dividerColor,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: AppColors.greyColor),
            borderRadius: BorderRadius.circular(10),
          ),
          suffixIcon: Icon(
            Icons.search,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ),
    );
  }
}
