import 'package:flutter/material.dart';
import 'package:doodi/constants/colors.dart';
import 'package:doodi/constants/text_style.dart';
import 'package:flutter/services.dart';

class GameCard extends StatefulWidget {
  final String question;
  final String optionA;
  final String optionB;
  final int likeCount;
  final int dislikeCount;

  const GameCard({
    super.key,
    required this.question,
    required this.optionA,
    required this.optionB,
    required this.likeCount,
    required this.dislikeCount,
  });

  @override
  State<GameCard> createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  bool isLiked = false;
  bool isDisliked = false;

  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 질문
            Text(
              widget.question,
              style: AppTextStyles.gameTitle.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
            const SizedBox(height: 15),

            // A, B 박스
            Row(
              children: [
                Expanded(
                  // 클릭할 수 있는 GestureDetector
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedOption = 'A';
                      });
                    },
                    // opacity 조절하는 AnimatedOpacity
                    child: AnimatedOpacity(
                      // 시간|수치 설정
                      duration: Duration(milliseconds: 150),
                      opacity: selectedOption == null || selectedOption == 'A'
                          ? 1.0
                          : 0.3,
                      child: Container(
                        height: 110,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: AppColors.pointBlue,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                        ),
                        child: Text(
                          widget.optionA,
                          style: AppTextStyles.free25.copyWith(
                            color: AppColors.pointYellow,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedOption = 'B';
                      });
                    },
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 150),
                      opacity: selectedOption == null || selectedOption == 'B'
                          ? 1.0
                          : 0.3,
                      child: Container(
                        height: 110,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: AppColors.pointYellow,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                        ),
                        child: Text(
                          widget.optionB,
                          style: AppTextStyles.free25.copyWith(
                            color: AppColors.pointBlue,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            // 좋아요/싫어요/삭제 버튼
            Row(
              children: [
                IconButton(
                  // 좋아요 토글 버튼
                  onPressed: () {
                    setState(() {
                      isLiked = !isLiked;
                      if (isLiked && isDisliked) isDisliked = false;
                    });
                  },
                  icon: Icon(
                    isLiked ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined,
                    size: 18,
                    color: isLiked
                        ? AppColors.pointBlue
                        : Theme.of(context).iconTheme.color,
                  ),
                ),
                // 클릭 시 1 증가
                Text('${widget.likeCount + (isLiked ? 1 : 0)}'),

                const SizedBox(width: 10),

                IconButton(
                  onPressed: () {
                    setState(() {
                      isDisliked = !isDisliked;
                      if (isDisliked && isLiked) isLiked = false;
                    });
                  },
                  icon: Icon(
                    isDisliked
                        ? Icons.thumb_down_alt
                        : Icons.thumb_down_alt_outlined,
                    size: 18,
                    color: isDisliked
                        ? Colors.redAccent
                        : Theme.of(context).iconTheme.color,
                  ),
                ),
                Text('${widget.dislikeCount + (isDisliked ? 1 : 0)}'),

                const Spacer(),

                TextButton(
                  onPressed: () {
                    // 삭제 버튼 클릭 시 표시되는 팝업창
                    showDialog<void>(
                      context: context,
                      barrierDismissible: true,

                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
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
                                Container(
                                  height: 55,
                                  child: TextField(
                                    maxLength: 4,
                                    obscureText: true,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    decoration: InputDecoration(
                                      hintText: '예) 1234',
                                      hintStyle: AppTextStyles.free15,
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            Container(
                              height: 25,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    child: Text(
                                      '취소',
                                      style: AppTextStyles.free13.copyWith(
                                        color: Theme.of(
                                          context,
                                        ).iconTheme.color,
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
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(
                    '삭제',
                    style: AppTextStyles.free15.copyWith(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
