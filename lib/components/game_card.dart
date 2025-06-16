import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:doodi/constants/colors.dart';
import 'package:doodi/constants/text_style.dart';
import 'package:flutter/services.dart';
import 'package:doodi/components/delete_dialog.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GameCard extends StatefulWidget {
  final int gameId;
  final String question;
  final String optionA;
  final String optionB;
  final int likeCount;
  final int dislikeCount;
  // 매개변수 없이 void 값을 반환
  final VoidCallback onDelete;

  const GameCard({
    super.key,
    required this.gameId,
    required this.question,
    required this.optionA,
    required this.optionB,
    required this.likeCount,
    required this.dislikeCount,
    required this.onDelete,
  });

  @override
  State<GameCard> createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  var apiurl = dotenv.env['API_URL'];

  bool isLiked = false;
  bool isDisliked = false;
  String? selectedOption;

  int answerACount = 0;
  int answerBCount = 0;

  int currentLikeCount = 0;
  int currentDislikeCount = 0;

  // --- A/B 투표 결과 저장하기 ---
  Future<void> vote(String selectedOption, BuildContext context) async {
    // votes 저장소 생성하기
    final box = Hive.box('votes');
    final gameId = widget.gameId;

    // color 변수
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppColors.darkModeColor : AppColors.whiteColor;
    final textColor = isDark ? AppColors.whiteColor : AppColors.blackColor;

    // 이미 해당 투표를 했을 경우 -> 투표 못하게 종료 -> 문구 띄우기
    if (box.containsKey(gameId)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '이미 투표한 게임입니다.',
            style: AppTextStyles.lightFree15.copyWith(color: textColor),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: bgColor,
        ),
      );
      return;
    }

    // 투표 데이터를 보낼 api 주소
    final url = Uri.parse('$apiurl/vote_game.php');
    final response = await http.post(
      url,
      // json 형식으로 game_id와 투표 결과를 post로 전달
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'game_id': gameId, 'selectedOption': selectedOption}),
    );

    // 중복 투표 방지용
    // hive에 게임id와 투표 결과를 저장
    box.put(gameId, selectedOption);
    // 선택한 답변을 상태로 저장시키고 -> UI에 반영
    setState(() {
      this.selectedOption = selectedOption;
    });
    // 마지막으로 서버에서 투표 수 가져오기
    fetchVoteCount();
  }

  // --- 서버에서 A,B 선택 수 가져오는 함수 ---
  Future<void> fetchVoteCount() async {
    // api 주소 요청, gameId를 파라미터로 전달
    final url = Uri.parse('$apiurl/get_count.php?game_id=${widget.gameId}');
    final response = await http.get(url);
    print('count response: ${response.body}');
    final data = jsonDecode(response.body);

    // 투표 수를 A,B 각자 상태값에 저장
    setState(() {
      answerACount = data['answerA'];
      answerBCount = data['answerB'];
    });
  }

  // --- 초기 세팅 ---
  @override
  void initState() {
    super.initState(); // 초기화

    currentLikeCount = widget.likeCount;
    currentDislikeCount = widget.dislikeCount;

    // --- 중복 투표 방지 ---
    final box = Hive.box('votes');
    // gameId에 해당하는 투표 결과가 저장되어 있는지 비교
    final stored = box.get(widget.gameId);
    // 투표한 기록이 있으면
    if (stored != null) {
      // 선택한 옵션을 seletedOption에 넣어 UI에 반영
      selectedOption = stored;
      // A,B 선택 수 가져오기
      fetchVoteCount();
    }

    // 기존 Hive 투표 상태 적용
    final likeBox = Hive.box('like_dislike');
    final key = 'game_${widget.gameId}';
    final action = likeBox.get(key);
    if (action != null) {
      isLiked = action == 'like';
      isDisliked = action == 'dislike';
    }
  }

  // --- 좋아요/싫어요 표시 ---
  Future<void> voteLikeDislike(String action) async {
    final box = Hive.box('like_dislike');
    final key = 'game_${widget.gameId}';

    // 이미 반응을 눌렀는지 확인
    final liked = box.get(key);
    if (liked != null) {
      return;
    }

    // api 호출
    final url = Uri.parse('$apiurl/vote_like.php');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      // game_id와 action(좋아요,싫어요) 가져오기
      body: jsonEncode({'game_id': widget.gameId, 'action': action}),
    );

    // 버튼 상태 관리
    setState(() {
      if (action == 'like') {
        isLiked = true;
        isDisliked = false;
        currentLikeCount += 1;
      } else {
        isDisliked = true;
        isLiked = false;
        currentDislikeCount += 1;
      }
    });

    // Hive에 상태 업데이트
    box.put(key, action);
  }

  // --- 게임 삭제하기 ---
  Future<void> deleteGame(BuildContext context) async {
    // color 변수
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppColors.darkModeColor : AppColors.whiteColor;
    final textColor = isDark ? AppColors.whiteColor : AppColors.blackColor;

    // TextEditingController:입력한 값 가져오는 클래스
    final passwordController = TextEditingController();

    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 7),
                child: Icon(Icons.error_outline),
              ),
              Text('게임 삭제', style: AppTextStyles.free17),
            ],
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '등록 시 설정한 4자리 비밀번호를 입력하세요.',
                textAlign: TextAlign.left,
                style: AppTextStyles.free12,
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 50,
                child: TextField(
                  controller: passwordController,
                  maxLength: 4,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '예) 1234',
                    hintStyle: AppTextStyles.free15,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 8,
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                '취소',
                style: AppTextStyles.free13.copyWith(
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(
                '삭제',
                style: AppTextStyles.free13.copyWith(
                  color: AppColors.pointBlue,
                ),
              ),
            ),
          ],
        );
      },
    );

    // '삭제'를 눌렀을 때
    if (result == true) {
      final pw = passwordController.text;

      final url = Uri.parse('$apiurl/delete_game.php');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'game_id': widget.gameId, 'pw': pw}),
      );
      final json = jsonDecode(response.body);

      if (json['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '삭제가 완료되었습니다.',
              style: AppTextStyles.lightFree15.copyWith(color: textColor),
            ),
            duration: Duration(seconds: 2),
            backgroundColor: bgColor,
          ),
        );
        widget.onDelete();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '비밀번호가 일치하지 않습니다.',
              style: AppTextStyles.lightFree15.copyWith(color: textColor),
            ),
            duration: Duration(seconds: 2),
            backgroundColor: bgColor,
          ),
        );
      }
    }
  }

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

            // 선택지 박스
            Row(
              children: [
                // A 박스
                Expanded(
                  // 클릭할 수 있는 GestureDetector
                  child: GestureDetector(
                    onTap: () {
                      if (selectedOption == null) {
                        setState(() {
                          selectedOption = 'A';
                        });
                        vote('A', context);
                      } else {
                        vote('A', context);
                      }
                    },

                    // opacity 조절하는 AnimatedOpacity
                    child: AnimatedOpacity(
                      // 시간|불투명도 설정
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.optionA,
                              style: AppTextStyles.free25.copyWith(
                                color: AppColors.pointYellow,
                              ),
                            ),
                            if (selectedOption != null)
                              Text(
                                '$answerACount명',
                                style: AppTextStyles.boldFree15.copyWith(
                                  color: AppColors.whiteColor,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // B 박스
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (selectedOption == null) {
                        setState(() {
                          selectedOption = 'B';
                        });

                        vote('B', context);
                      } else {
                        vote('B', context);
                      }
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.optionB,
                              style: AppTextStyles.free25.copyWith(
                                color: AppColors.pointBlue,
                              ),
                            ),
                            if (selectedOption != null)
                              Text(
                                '$answerBCount명',
                                style: AppTextStyles.boldFree15.copyWith(
                                  color: AppColors.blackColor,
                                ),
                              ),
                          ],
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
                    if (!isLiked) {
                      voteLikeDislike('like');
                    }
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
                Text('$currentLikeCount'),

                const SizedBox(width: 10),

                IconButton(
                  onPressed: () {
                    if (!isDisliked) {
                      voteLikeDislike('dislike');
                    }
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
                Text('$currentDislikeCount'),

                const Spacer(),

                // 삭제 버튼
                TextButton(
                  onPressed: () => deleteGame(context),
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
