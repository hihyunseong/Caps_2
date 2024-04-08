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
            SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: TextFormField(
                textAlign: TextAlign.center, 
                decoration: InputDecoration(
                  hintText: '사용자', 
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 20.0), 
            TextButton(
              onPressed: () {
               
              },
              child: Text(
                '전체지도',
                style: TextStyle(letterSpacing: 1.5), 
              ),
            ),
            TextButton(
              onPressed: () {
              
              },
              child: Text(
                '지도나가기',
                style: TextStyle(letterSpacing: 1.5), 
              ),
            ),
            TextButton(
              onPressed: () {
                
              },
              child: Text(
                '이용약관',
                style: TextStyle(letterSpacing: 1.5), 
              ),
            ),
            TextButton(
              onPressed: () {
                
              },
              child: Text(
                '버전',
                style: TextStyle(letterSpacing: 1.5), 
              ),
            ),
            TextButton(
              onPressed: () {
               
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()), 
                );
              },
              child: Text(
                '로그아웃',
                style: TextStyle(letterSpacing: 1.5), 
              ),
            ),
            TextButton(
              onPressed: () {
               
              },
              child: Text(
                '탈퇴하기',
                style: TextStyle(
                  letterSpacing: 1.5, 
                  color: Colors.red, 
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

 
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
