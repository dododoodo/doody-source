import 'package:doodi/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:doodi/constants/colors.dart';
import 'package:doodi/constants/text_style.dart';
import 'package:doodi/components/game_card.dart';

List<Map<String, dynamic>> gameList = [
  {
    'question': '가장 가지고 싶은 초능력은?',
    'optionA': '염력',
    'optionB': '투명인간',
    'like': 5,
    'dislike': 1,
  },
  {
    'question': '제일 맛있는 햄버거는?',
    'optionA': '롯데리아',
    'optionB': '맥도날드',
    'like': 2,
    'dislike': 4,
  },
  {
    'question': '가장 가고 싶은 자연은?',
    'optionA': '산',
    'optionB': '바다',
    'like': 7,
    'dislike': 0,
  },
];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Home> {
  final ScrollController _scrollController = ScrollController();

  void scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: Duration(milliseconds: 350),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              SizedBox(height: 20),

              // 검색 창
              SizedBox(
                width: double.infinity,
                height: 35,
                child: TextField(
                  cursorColor: const Color(0xff7f7f7f),
                  style: AppTextStyles.free12.copyWith(
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
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
                        color: AppColors.darkModeColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: AppColors.greyColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: Icon(
                      Icons.search,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 40),

              // 밸런스 게임 카드
              ListView.builder(
                physics: NeverScrollableScrollPhysics(), // 사용자 스크롤 막기
                shrinkWrap: true, // 자식 아이템 크기만큼만 공간 차지
                controller: _scrollController,
                itemCount: gameList.length,
                itemBuilder: (context, index) {
                  final game = gameList[index];
                  // GameCard 컴포넌트
                  return GameCard(
                    question: game['question'],
                    optionA: game['optionA'],
                    optionB: game['optionB'],
                    likeCount: game['like'],
                    dislikeCount: game['dislike'],
                  );
                },
              ),

              SizedBox(height: 40),
            ],
          ),
        ),

        // 탑 버튼
        Positioned(
          bottom: 30,
          right: 24,
          child: FloatingActionButton(
            shape: const CircleBorder(),
            mini: true,
            onPressed: scrollToTop,
            backgroundColor: AppColors.pointYellow,
            child: const Icon(Icons.arrow_upward, color: AppColors.pointBlue),
          ),
        ),
      ],
    );
  }
}
