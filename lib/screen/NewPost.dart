import 'package:flutter/material.dart';

class NewPost extends StatefulWidget {
  const NewPost({super.key});

  @override
  State<NewPost> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<NewPost> {
  final formKey = GlobalKey<FormState>();

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
            child: Text(
              '나만의 밸런스 게임을\n등록하세요!',
              style: TextStyle(
                fontFamily: 'ria-r',
                fontSize: 17,
                color: Color.fromARGB(255, 28, 35, 49),
              ),
            ),
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
                            Text(
                              item['title'],
                              style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 28, 35, 49),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  item['description-type'],
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Color.fromARGB(255, 34, 39, 247),
                                  ),
                                ),
                                SizedBox(width: 3),
                                Text(
                                  item['description-num'],
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Color.fromARGB(255, 28, 35, 49),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10),

                        // 입력창
                        TextFormField(
                          // validator: (value) => null,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 0.7,
                                color: Color.fromARGB(255, 92, 92, 92),
                              ),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1.5,
                                color: const Color.fromARGB(255, 34, 39, 247),
                                // color: const Color.fromARGB(255, 251, 230, 42),
                              ),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            hintText: item['placeholder'],
                            hintStyle: TextStyle(
                              color: Color.fromARGB(100, 118, 118, 118),
                              fontSize: 13,
                            ),
                          ),
                          style: TextStyle(
                            color: Color.fromARGB(255, 28, 35, 49),
                          ),
                          // onSaved: (value) {
                          //   sContent = value;
                          // },
                        ),

                        // 입력창 하단 텍스트 (비밀번호 입력창만 있음)
                        if (hasMore)
                          Container(
                            margin: EdgeInsets.only(top: 7),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              item['description-more'],
                              style: TextStyle(
                                fontSize: 10,
                                color: Color.fromARGB(255, 118, 118, 118),
                              ),
                            ),
                          ),
                        SizedBox(height: 14),
                      ],
                    );
                  },
                ),

                // 02-2. 등록 버튼
                // Expanded 밖에 두면 화면 최하단에 위치하여 안에 넣어야 함.
                Container(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 251, 230, 42),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                    child: Text(
                      '등록하기',
                      style: TextStyle(
                        fontSize: 13,
                        color: const Color.fromARGB(255, 34, 39, 247),
                      ),
                    ),
                  ),
                ),

                Column(
                  children: [
                    Text(
                      '※ 밸런스 게임 질문 등록 시 주의사항',
                      style: TextStyle(
                        fontFamily: 'free-2',
                        fontSize: 12,
                        color: Color.fromARGB(255, 118, 118, 118),
                      ),
                    ),
                    Text(
                      '- 다른 사용자에게 위화감을 조성하거나 특정 사용자를 비난/저격/공격하는 질문은 관리자에 의해 삭제될 수 있습니다.\n- 초상권/저작권 침해 등 타인의 권리를 침해하는 글은 관리자에 의해 삭제될 수 있습니다.\n- 비방/차별/인신공격이 포함되거나 욕설이 포함된 글은 관리자에 의해 삭제될 수 있습니다.',
                      style: TextStyle(
                        fontFamily: 'free-2',
                        fontSize: 10,
                        color: Color.fromARGB(255, 118, 118, 118),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
