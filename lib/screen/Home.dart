import 'package:flutter/material.dart';
import 'package:doodi/constants/colors.dart';
import 'package:doodi/constants/text_style.dart';
import 'package:doodi/components/game_card.dart';
import 'package:doodi/components/search_field.dart';
import 'package:hive_flutter/adapters.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

// Map의 key가 String, value는 dynamic(뭐든 가능)

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Home> {
  final ScrollController _scrollController = ScrollController();

  // 게임 데이터 가져오기
  List<Map<String, dynamic>> gameList = [];

  // --- 검색 기능 ---
  // 사용자가 입력한 검색어 저장
  String keyword = '';

  // keyword에 따라서 게임목록 필터링
  List<Map<String, dynamic>> get filteredGameList {
    // 검색어 없을 시 전체 리스트 표시
    if (keyword.isEmpty) return gameList;

    // 검색어가 있는 경우, 해당 단어가 있는 게임만 필터링해서 표시
    return gameList.where((game) {
      // game의 question 중, keyword가 포함된 게임 있는지 찾기
      return game['question'].toString().contains(keyword);
    }).toList();
  }

  // --- 게임 데이터 받아서 Card로 표시 ---
  // php서버가 데이터를 보내주게 함 (await로 비동기처리)
  Future<void> fetchGames() async {
    final response = await http.get(
      Uri.parse("http://localhost/doody/api/get_games.php"),
    );

    // json으로 받은걸 dart 객체로 바꾸기
    final List<dynamic> jsonData = json.decode(response.body);

    // 렌더링
    setState(() {
      // gameList에 저장시켜서 자동 갱신
      gameList = jsonData
          .map(
            (game) => {
              'gameId': int.parse(game['id'].toString()),
              'question': game['quest'],
              'answerA': game['answerA'],
              'answerB': game['answerB'],
              'like': int.parse(game['like_count']),
              'dislike': int.parse(game['dislike_count']),
            },
          )
          .toList();
    });
  }

  @override
  // initState:초기 설정 작업
  void initState() {
    super.initState();
    fetchGames(); // 게임 데이터 함수 호출
  }

  void scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: Duration(milliseconds: 350),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        mini: true,
        onPressed: scrollToTop,
        backgroundColor: AppColors.pointYellow,
        child: Icon(Icons.arrow_upward, color: AppColors.pointBlue),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            const SizedBox(height: 20),

            // 검색창
            SearchField(
              onChanged: (value) {
                setState(() {
                  keyword = value;
                });
              },
            ),
            const SizedBox(height: 40),

            // 카드 & 결과 없음 표시
            if (filteredGameList.isEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 180),
                child: Column(
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    SizedBox(height: 5),
                    Text(
                      '검색어와 일치하는\n게임이 없습니다.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontFamily: 'free-4',
                        fontSize: 12,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.lineColor
                            : AppColors.darkModeColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredGameList.map(
                (game) => GameCard(
                  gameId: game['gameId'],
                  question: game['question'],
                  optionA: game['answerA'],
                  optionB: game['answerB'],
                  likeCount: game['like'],
                  dislikeCount: game['dislike'],
                  onDelete: () {
                    setState(() {
                      gameList.removeWhere(
                        (i) => i['gameId'] == game['gameId'],
                      );
                    });
                  },
                ),
              ),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
