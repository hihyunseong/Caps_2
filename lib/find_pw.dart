import 'package:flutter/material.dart';
import 'find_id.dart'; 
import 'find_pw2.dart';

class FindPw extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: FractionalOffset(0.4,0), 
          child: Text('비밀번호 찾기'),
        ),
      ),
     body: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text.rich(
              TextSpan(
                text: '가입하신 \n',
                style: TextStyle(
                  fontSize: 18.0,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '이메일 주소',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: '를 입력해 주세요.',
                  ),
                ],
              ),
            ),  
            SizedBox(height: 40), 
            Container(
            padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'pinkok@email.com',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: GestureDetector(
                      onTap: () {
                      },
                      child: Text(
                        '인증요청',
                        style: TextStyle(color: Color(0xFFFF6F61), fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 320), 
            Container(
              width: double.infinity,
              child: ElevatedButton( 
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FindPw2()), 
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
              
                  backgroundColor: Color(0xFFFF6F61) 
                ),           
                child: Container(
                  alignment: Alignment.center, 
                  width: double.infinity,
                  child: Text(
                    '비밀번호 찾기',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),        
          ],
        ),
      ),
     ),
    );
  }
}
