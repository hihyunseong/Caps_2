import 'package:flutter/material.dart';
import 'login.dart';

class FindPw3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('새로운 비밀번호 설정'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: '새로운 비밀번호',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                labelText: '비밀번호 확인',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 새로운 비밀번호 저장 및 확인 버튼 클릭 시 처리
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text('확인'),
              ),
            ),
            SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                // 취소 버튼 클릭 시 LoginPage로 이동
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()), 
                );
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text('취소'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
