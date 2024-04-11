import 'package:flutter/material.dart';
import 'find_id.dart'; 
import 'find_pw2.dart';

class FindPw extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('아이디 입력'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40), 
            Center(
              child: Text(
                '비밀번호를 찾고자 하는\n아이디를 입력해주세요.',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center, 
              ),
            ),
            SizedBox(height: 20), 
            TextField( 
              decoration: InputDecoration(
                labelText: '아이디', 
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(), 
              ),
            ),
            SizedBox(height: 20), 
            Container(
              width: double.infinity,
              child: ElevatedButton( 
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FindPw2()), 
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue), 
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0), 
                    ),
                  ),
                ),
                child: Container(
                  alignment: Alignment.center, 
                  width: double.infinity,
                  child: Text(
                    '다음',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FindId()),
                );
              },
              splashColor: Colors.transparent,
              child: Text.rich( 
                TextSpan(
                  text: '아이디를 잊으셨나요? ',
                  style: TextStyle(fontSize: 12),
                  children: <TextSpan>[
                    TextSpan(
                      text: '아이디 찾기',
                      style: TextStyle(fontSize: 12, color: Colors.blue), 
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
