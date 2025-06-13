import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:doodi/constants/colors.dart';
import 'package:doodi/constants/text_style.dart';

class DeleteGameDialog extends StatelessWidget {
  final VoidCallback onDelete;

  const DeleteGameDialog({super.key, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 5),
            child: Icon(Icons.error_outline),
          ),
          Text(
            '게임을 삭제하시겠습니까?',
            style: AppTextStyles.free15.copyWith(
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              '게임을 삭제하려면 \n게임 등록 시 설정한 비밀번호를 입력하세요.',
              style: AppTextStyles.lightFree12.copyWith(
                color: Theme.of(context).iconTheme.color,
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 55,
              child: TextField(
                maxLength: 4,
                obscureText: true,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  hintText: '예) 1234',
                  hintStyle: AppTextStyles.free15,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        SizedBox(
          height: 25,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                child: Text(
                  '취소',
                  style: AppTextStyles.free13.copyWith(
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(
                  '삭제',
                  style: AppTextStyles.free15.copyWith(
                    color: AppColors.pointBlue,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  onDelete();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
