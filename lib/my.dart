import 'package:flutter/material.dart';
import 'login.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                // 사진 선택 다이얼로그 표시
                _showImagePickerDialog(context);
              },
              child: CircleAvatar(
                radius: 50.0,
                backgroundColor: Colors.grey[200],
                child: Icon(
                  Icons.person,
                  size: 50.0,
                  color: Colors.grey[600],
                ),
              ),
            ),
            SizedBox(height: 10.0), // 버튼과 텍스트 필드 사이에 여백 추가
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: TextFormField(
                textAlign: TextAlign.center, // 텍스트 가운데 정렬
                decoration: InputDecoration(
                  hintText: '사용자', 
                  border: InputBorder.none, // 테두리 없음 설정
                ),
              ),
            ),
            SizedBox(height: 20.0), // 추가한 버튼 위에 여백 추가
            TextButton(
              onPressed: () {
                // 전체지도 기능 구현
              },
              child: Text(
                '전체지도',
                style: TextStyle(letterSpacing: 1.5), // 글자 간격 조정
              ),
            ),
            TextButton(
              onPressed: () {
                // 지도나가기 기능 구현
              },
              child: Text(
                '지도나가기',
                style: TextStyle(letterSpacing: 1.5), // 글자 간격 조정
              ),
            ),
            TextButton(
              onPressed: () {
                // 이용약관 기능 구현
              },
              child: Text(
                '이용약관',
                style: TextStyle(letterSpacing: 1.5), // 글자 간격 조정
              ),
            ),
            TextButton(
              onPressed: () {
                // 버전 정보 표시 기능 구현
              },
              child: Text(
                '버전',
                style: TextStyle(letterSpacing: 1.5), // 글자 간격 조정
              ),
            ),
            TextButton(
              onPressed: () {
                // 로그아웃 기능 구현
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()), // LoginPage는 로그인 페이지의 이름입니다.
                );
              },
              child: Text(
                '로그아웃',
                style: TextStyle(letterSpacing: 1.5), // 글자 간격 조정
              ),
            ),
            TextButton(
              onPressed: () {
                // 탈퇴하기 기능 구현
              },
              child: Text(
                '탈퇴하기',
                style: TextStyle(
                  letterSpacing: 1.5, // 글자 간격 조정
                  color: Colors.red, // 빨간색으로 변경
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 이미지 선택 다이얼로그 표시 함수
  void _showImagePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('사진 선택'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text('갤러리에서 선택'),
                  onTap: () {
                    // 갤러리에서 이미지 선택
                    // 선택된 이미지를 처리하거나 저장하는 로직을 추가해야 합니다.
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(height: 10.0),
                GestureDetector(
                  child: Text('카메라로 촬영'),
                  onTap: () {
                    // 카메라로 촬영하여 이미지 선택
                    // 선택된 이미지를 처리하거나 저장하는 로직을 추가해야 합니다.
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
