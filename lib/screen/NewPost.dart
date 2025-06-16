import 'package:flutter/material.dart';
import 'package:doodi/components/alerts.dart';
import 'package:doodi/constants/colors.dart';
import 'package:doodi/constants/text_style.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class NewPost extends StatefulWidget {
  void Function(int) changeIndex; // main으로부터 콜백함수를 받아 등록 버튼 클릭 시 홈으로 이동.
  NewPost({super.key, required this.changeIndex});

  @override
  State<NewPost> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<NewPost> {
  final formKey = GlobalKey<FormState>();
  bool hasEmptyField = false; // 비어있는 필드일 경우 팝업 생성
  bool isPasswordObscured = true; // 비밀번호 필드 가림 여부

  // textfield 변수
  String quest = '';
  String answerA = '';
  String answerB = '';
  String pw = '';

  void postFormData(context) async {
    formKey.currentState!.save(); // 여기서 onSaved 실행됨

    // var url = Uri.parse('http://localhost/php/api/game.php');
    var url = Uri.parse('http://localhost/doody/api/game.php');
    var res = await http.post(
      url,
      body: {'quest': quest, 'answerA': answerA, 'answerB': answerB, 'pw': pw},
    );

    if (res.statusCode == 200) {
      print('서버 응답: ${res.body}');
      widget.changeIndex(0);
    } else {
      print('서버 오류: ${res.statusCode}');
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
                          style: AppTextStyles.free13,
                          validator: (value) {
                            // 값이 null이거나 비어있으면 통과 X
                            if (value == null || value.isEmpty) {
                              return '*항목을 입력해주세요!';
                            }

                            // 비밀번호 검증
                            if (idx == 3) {
                              final pwReg = RegExp(r'^\d{4}$'); // 숫자 4자리 정규식
                              if (!pwReg.hasMatch(value)) {
                                return '*4자리 숫자만 입력할 수 있어요!';
                              }
                            }
                            return null;
                          },
                          obscureText: idx == 3 ? isPasswordObscured : false,
                          obscuringCharacter: '*',
                          decoration: InputDecoration(
                            hintText: item['placeholder'],
                            hintStyle: AppTextStyles.lightFree12,
                            suffixIcon: idx == 3
                                ? IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isPasswordObscured =
                                            !isPasswordObscured;
                                      });
                                    },
                                    icon: Icon(
                                      isPasswordObscured
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      size: 18,
                                      weight: 1.5,
                                    ),
                                  )
                                : null,
                          ),

                          onChanged: (value) {
                            // index 값에 따라 값 할당
                            if (idx == 0) {
                              quest = value;
                            } else if (idx == 1) {
                              answerA = value;
                            } else if (idx == 2) {
                              answerB = value;
                            } else if (idx == 3) {
                              pw = value;
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
                              style: AppTextStyles.lightFree10,
                            ),
                          ),
                        SizedBox(height: 24),
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
                        // 입력 필드가 비어있을 경우 dialog 띄우기
                        bool hasEmptyField =
                            quest.isEmpty ||
                            answerA.isEmpty ||
                            answerB.isEmpty ||
                            pw.isEmpty;

                        if (hasEmptyField) {
                          showDialog(
                            context: context,
                            builder: (context) => Alerts(type: 'empty'),
                          );
                        }
                        return;
                      }

                      // 제대로 작성했을 경우 서버에 저장 후 홈으로 이동.
                      postFormData(context);
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
                SizedBox(height: 24),

                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '※ 밸런스 게임 질문 등록 시 주의사항',
                        style: AppTextStyles.lightFree12,
                      ),
                      SizedBox(height: 3),
                      Text(
                        '- 다른 사용자에게 위화감을 조성하거나 특정 사용자를 비난/저격/공격하는 질문은 관리자에 의해 삭제될 수 있습니다.\n- 초상권/저작권 침해 등 타인의 권리를 침해하는 글은 관리자에 의해 삭제될 수 있습니다.\n- 비방/차별/인신공격이 포함되거나 욕설이 포함된 글은 관리자에 의해 삭제될 수 있습니다.',
                        style: AppTextStyles.lightFree10,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 14),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void emptyDialog(context) {
    showDialog(
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
                '알림',
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
                  '필수 입력 항목을 작성하지 않았습니다.',
                  style: AppTextStyles.lightFree12.copyWith(
                    color: Theme.of(context).iconTheme.color,
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
                      '확인',
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
  }
}
