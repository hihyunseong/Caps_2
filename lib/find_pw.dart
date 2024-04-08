import 'package:flutter/material.dart';
import 'find_id.dart'; // 다음 화면 import
import 'find_pw2.dart'; // FindPw2 화면 import

class FindPw extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('아이디 입력'), // 어플 로고를 가운데 정렬
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40), // 전체적으로 위로 올리기 위한 여백 추가
            Center(
              child: Text(
                '비밀번호를 찾고자 하는\n아이디를 입력해주세요.',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center, // 텍스트 가운데 정렬
              ),
            ),
            SizedBox(height: 20), // 텍스트와 TextField 사이 간격 조절
            TextField( // 아이디를 입력할 수 있는 상자
              decoration: InputDecoration(
                labelText: '아이디', // 입력 상자 위에 표시할 텍스트
                prefixIcon: Icon(Icons.lock), // 상자 왼쪽에 로고 아이콘 표시
                border: OutlineInputBorder(), // 상자 모서리에 선 표시
              ),
            ),
            SizedBox(height: 20), // 아이디 입력 상자 아래 간격 추가
            Container(
              width: double.infinity,
              child: ElevatedButton( // 다음 버튼
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FindPw2()), // FindPw2 화면으로 이동
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue), // 버튼의 배경색
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0), // 버튼의 모서리를 둥글게
                    ),
                  ),
                ),
                child: Container(
                  alignment: Alignment.center, // 텍스트 가운데 정렬
                  width: double.infinity,
                  child: Text(
                    '다음',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10), // 다음 버튼과 아이디 찾기 텍스트 사이 간격 추가
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FindId()), // 다음 화면으로 이동
                );
              },
              splashColor: Colors.transparent, // 터치 효과 색상 설정
              child: Text.rich( // 아이디 찾기 텍스트
                TextSpan(
                  text: '아이디를 잊으셨나요? ',
                  style: TextStyle(fontSize: 12),
                  children: <TextSpan>[
                    TextSpan(
                      text: '아이디 찾기',
                      style: TextStyle(fontSize: 12, color: Colors.blue), // 색상 변경
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
