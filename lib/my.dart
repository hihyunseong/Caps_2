import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'login.dart';
import 'friends/friends.dart';
import 'home.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  XFile? _image;

  String? idx;
  String? email;
  String? name;
  String? accToken;
  String? refToken;

  @override
  void initState() {
    super.initState();
    _loadFromStorage();
  }

  Future<void> _loadFromStorage() async {
    final storage = FlutterSecureStorage();

    final loadIdx = await storage.read(key: 'idx');
    final loadEmail = await storage.read(key: 'email');
    final loadName = await storage.read(key: 'name');
    final loadAccToken = await storage.read(key: 'accToken');
    final loadRefToken = await storage.read(key: 'refToken');

    setState(() {
      idx = loadIdx;
      email = loadEmail;
      name = loadName;
      accToken = loadAccToken;
      refToken = loadRefToken;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                _showImagePickerDialog(context);
              },
              child: _image == null
                  ? CircleAvatar(
                      radius: 40.0,
                      backgroundColor: Colors.grey[200],
                      child: Icon(
                        Icons.person,
                        size: 40.0,
                        color: Colors.grey[600],
                      ),
                    )
                  : CircleAvatar(
                      radius: 40.0,
                      backgroundImage: FileImage(
                        File(_image!.path),
                      ),
                    ),
            ),
            const SizedBox(height: 10.0),
            const Divider(color: Colors.grey),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Friends()),
                );
              },
              child: const Text(
                '친구리스트',
                style: TextStyle(
                    color: Colors.black, letterSpacing: 1.5, fontSize: 18),
              ),
            ),
            const Divider(color: Colors.grey),
            TextButton(
              onPressed: () {},
              child: const Text(
                '전체지도',
                style: TextStyle(
                    color: Colors.black, letterSpacing: 1.5, fontSize: 18),
              ),
            ),
            const Divider(color: Colors.grey),
            TextButton(
              onPressed: () {},
              child: const Text(
                '이용약관',
                style: TextStyle(
                    color: Colors.black, letterSpacing: 1.5, fontSize: 18),
              ),
            ),
            const Divider(color: Colors.grey),
            TextButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('사용자 정보'),
                      content: Text('idx :' +
                          idx.toString() +
                          "\n" +
                          '이름 :' +
                          name.toString() +
                          "\n" +
                          '이메일 :' +
                          email.toString() +
                          "\n" +
                          '엑세스 토큰 :' +
                          accToken.toString() +
                          "\n" +
                          '리프레시 토큰 :' +
                          refToken.toString() +
                          "\n"),
                    );
                  },
                );
              },
              child: const Text(
                '버전',
                style: TextStyle(
                    color: Colors.black, letterSpacing: 1.5, fontSize: 18),
              ),
            ),
            const Divider(color: Colors.grey),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text(
                '로그아웃',
                style: TextStyle(
                    color: Colors.black, letterSpacing: 1.5, fontSize: 18),
              ),
            ),
            const Divider(color: Colors.grey),
            TextButton(
              onPressed: () {
                const storage = FlutterSecureStorage();
                storage.deleteAll();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: const Text(
                '탈퇴하기',
                style: TextStyle(
                    letterSpacing: 1.5, color: Colors.red, fontSize: 18),
              ),
            ),
            const Divider(color: Colors.grey),
            const SizedBox(
              height: 50.0,
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
