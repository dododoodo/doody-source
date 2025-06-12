import 'package:flutter/material.dart';
import 'package:doodi/constants/colors.dart';
import 'package:doodi/constants/text_style.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewPost extends StatefulWidget {
  const NewPost({super.key});

  @override
  State<NewPost> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<NewPost> {
  final formKey = GlobalKey<FormState>();
  String quest = '';
  String answerA = '';
  String answerB = '';
  String pw = '';

  void postFormData() async {
    formKey.currentState!.save(); // 여기서 onSaved 실행됨

    var url = Uri.http('localhost', '/php/api/game.php');
    var response = await http.post(
      url,
      body: {'quest': quest, 'answerA': answerA, 'answerB': answerB, 'pw': pw},
    );

    if (response.statusCode == 200) {
      print('서버 응답: ${response.body}');
    } else {
      print('서버 오류: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    // form 입력창 표시를 위한 데이터. (ListView 사용)
    List<Map<String, dynamic>> formData = [
      {
        "title": '질문',
        "description-type": '(필수)',
        "description-num": '최대 30자까지 작성할 수 있습니다.',
        "placeholder": '예 ) 무인도에 한 개만 가져갈 수 있다면?',
      },
      {
        "title": 'A 답변',
        "description-type": '(필수)',
        "description-num": '최대 50자까지 작성할 수 있습니다.',
        "placeholder": '예 ) 무인도 생존 만화책',
      },
      {
        "title": 'B 답변',
        "description-type": '(필수)',
        "description-num": '최대 50자까지 작성할 수 있습니다.',
        "placeholder": '예 ) 반절 남은 라이터',
      },
      {
        "title": '비밀번호',
        "description-type": '(필수)',
        "description-num": '4자리 숫자만 입력 가능합니다.',
        "placeholder": '예 ) 1234',
        "description-more": '추후에 질문 삭제 시 비밀번호가 필요합니다.',
      },
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 01. 페이지 타이틀
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 24),
            child: Text('나만의 밸런스 게임을\n등록하세요!', style: AppTextStyles.pageTitle),
          ),

          // 02. 입력창 (form)
          Form(
            key: formKey,
            child: Column(
              children: [
                // 02-1. 입력창 리스트
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(), // 사용자 스크롤 막기
                  shrinkWrap: true, // 자식 아이템 크기만큼만 공간 차지
                  itemCount: formData.length,
                  itemBuilder: (context, idx) {
                    final item = formData[idx];
                    final hasMore = item['description-more'] != null;

                    return Column(
                      children: [
                        // 입력창 상단 텍스트 (타이틀 및 최대 글자수 표시)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(item['title'], style: AppTextStyles.free15),
                            Row(
                              children: [
                                Text(
                                  item['description-type'],
                                  style: AppTextStyles.free10.copyWith(
                                    color: AppColors.pointBlue,
                                  ),
                                ),
                                SizedBox(width: 3),
                                Text(
                                  item['description-num'],
                                  style: AppTextStyles.free10,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10),

                        // 입력창
                        TextFormField(
                          validator: (value) {
                            // 값이 null이거나 비어있으면 통과 X
                            if (value == null || value.isEmpty) {
                              return '*항목을 입력해주세요.';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 0.7,
                                color: AppColors.lineColor,
                              ),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1.5,
                                color: AppColors.pointBlue,
                                // color: const Color.fromARGB(255, 251, 230, 42),
                              ),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            hintText: item['placeholder'],
                            hintStyle: AppTextStyles.lightFree12.copyWith(
                              color: AppColors.greyColor,
                            ),
                          ),
                          onSaved: (value) {
                            // index 값에 따라 값 할당
                            if (idx == 0) {
                              quest = value ?? '';
                            } else if (idx == 1) {
                              answerA = value ?? '';
                            } else if (idx == 2) {
                              answerB = value ?? '';
                            } else if (idx == 3) {
                              pw = value ?? '';
                            }
                          },
                        ),

                        // 입력창 하단 텍스트 (비밀번호 입력창만 있음)
                        if (hasMore)
                          Container(
                            margin: EdgeInsets.only(top: 7),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              item['description-more'],
                              style: AppTextStyles.free10.copyWith(
                                color: AppColors.greyColor,
                              ),
                            ),
                          ),
                        SizedBox(height: 14),
                      ],
                    );
                  },
                ),

                // 02-2. 등록 버튼
                Container(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      final isVaild = formKey.currentState!.validate();

                      if (!isVaild) {
                        // 값이 입력되지 않으면 dialog 표시
                        warning(context);
                      } else {
                        // 값이 유효할 경우 다음 동작 수행
                        postFormData();
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.pointYellow,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                    child: Text(
                      '등록하기',
                      style: AppTextStyles.free13.copyWith(
                        color: AppColors.pointBlue,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 14),

                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '※ 밸런스 게임 질문 등록 시 주의사항',
                        style: AppTextStyles.lightFree12.copyWith(
                          color: AppColors.greyColor,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        '- 다른 사용자에게 위화감을 조성하거나 특정 사용자를 비난/저격/공격하는 질문은 관리자에 의해 삭제될 수 있습니다.\n- 초상권/저작권 침해 등 타인의 권리를 침해하는 글은 관리자에 의해 삭제될 수 있습니다.\n- 비방/차별/인신공격이 포함되거나 욕설이 포함된 글은 관리자에 의해 삭제될 수 있습니다.',
                        style: AppTextStyles.lightFree10.copyWith(
                          color: AppColors.greyColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void warning(context) {
    showDialog(
      context: context,
      builder: (context) {
        return Align(
          alignment: Alignment.centerLeft,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: AppColors.whiteColor,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline_rounded),
                      SizedBox(width: 5),
                      Text('알림', style: AppTextStyles.free15),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    '필수 입력 항목을 작성하지 않았습니다.',
                    style: AppTextStyles.free10.copyWith(
                      color: AppColors.greyColor,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        '확인',
                        style: AppTextStyles.free13.copyWith(
                          color: AppColors.pointBlue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
