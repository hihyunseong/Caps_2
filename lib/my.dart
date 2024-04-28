import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
<<<<<<< HEAD
import 'package:image_picker/image_picker.dart';
=======
>>>>>>> 2a06014e4fc2630229c467b31b64023e4121e6d5
import 'login.dart';
import 'friends/friends.dart';
import 'home.dart';

<<<<<<< HEAD
class MyPage extends StatefulWidget {
=======
class MyPage extends StatelessWidget {

>>>>>>> 2a06014e4fc2630229c467b31b64023e4121e6d5
  static final storage = FlutterSecureStorage();

  static String? idx;
  static String? email;
  static String? name;
  static String? accToken;
  static String? refToken;

<<<<<<< HEAD
  static void UserInfo() async {
=======
  static void UserInfo() async{
>>>>>>> 2a06014e4fc2630229c467b31b64023e4121e6d5
    idx = await storage.read(key: 'idx');
    email = await storage.read(key: 'email');
    name = await storage.read(key: 'name');
    accToken = await storage.read(key: 'accToken');
    refToken = await storage.read(key: 'refToken');
  }

<<<<<<< HEAD
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  XFile? _image;

=======
>>>>>>> 2a06014e4fc2630229c467b31b64023e4121e6d5
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => Home()),
            );
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
              child: _image == null
                  ? CircleAvatar(
                      radius: 50.0,
                      backgroundColor: Colors.grey[200],
                      child: Icon(
                        Icons.person,
                        size: 50.0,
                        color: Colors.grey[600],
                      ),
                    )
                  : CircleAvatar(
                      radius: 50.0,
                      backgroundImage: FileImage(
                        File(_image!.path),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Friends()),
                );
              },
              child: Text(
                '친구리스트',
                style: TextStyle(letterSpacing: 1.5),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                '전체지도',
                style: TextStyle(letterSpacing: 1.5),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                '이용약관',
                style: TextStyle(letterSpacing: 1.5),
              ),
            ),
            TextButton(
<<<<<<< HEAD
              onPressed: () {
                MyPage.UserInfo();
=======
              onPressed: (){
                UserInfo();
>>>>>>> 2a06014e4fc2630229c467b31b64023e4121e6d5
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('사용자 정보'),
<<<<<<< HEAD
                      content: Text('idx :' +
                          MyPage.idx.toString() +
                          "\n" +
                          '이름 :' +
                          MyPage.name.toString() +
                          "\n" +
                          '이메일 :' +
                          MyPage.email.toString() +
                          "\n" +
                          '엑세스 토큰 :' +
                          MyPage.accToken.toString() +
                          "\n" +
                          '리프레시 토큰 :' +
                          MyPage.refToken.toString() +
                          "\n"),
                    );
                  },
                );
=======
                      content: Text(
                        'idx :' + idx.toString() + "\n"+
                        '이름 :' + name.toString() + "\n"+
                        '이메일 :' + email.toString() + "\n"+
                        '엑세스 토큰 :' + accToken.toString() + "\n"+
                        '리프레시 토큰 :' + refToken.toString() + "\n"
                      ),
                    );
                  },
                );

>>>>>>> 2a06014e4fc2630229c467b31b64023e4121e6d5
              },
              child: Text(
                '버전',
                style: TextStyle(letterSpacing: 1.5),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
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
                  onTap: () async {    
                    final ImagePicker picker = ImagePicker();
                    final XFile? image = await picker.pickImage(
                      source: ImageSource.gallery,
                    );
                    setState(() {
                      _image = image;
                    });
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(height: 10.0),
                GestureDetector(
                  child: Text('카메라로 촬영'),
                  onTap: () async {
                 
                    final ImagePicker picker = ImagePicker();
                    final XFile? image = await picker.pickImage(
                      source: ImageSource.camera,
                    );
                    setState(() {
                      _image = image;
                    });
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
