import 'dart:io';

import 'package:caps_2/friend/page/friend_page.dart';
import 'package:caps_2/friend/provider/friend_provider.dart';
import 'package:caps_2/my/page/update_profile_page.dart';
import 'package:caps_2/provider/map_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../login.dart';

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
  String? profile;
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
    final loadProfile = await storage.read(key: 'profile');
    final loadAccToken = await storage.read(key: 'accToken');
    final loadRefToken = await storage.read(key: 'refToken');

    setState(() {
      idx = loadIdx;
      email = loadEmail;
      name = loadName;
      profile = loadProfile;
      accToken = loadAccToken;
      refToken = loadRefToken;
    });
  }

  @override
  Widget build(BuildContext context) {
    MapProvider mapProvider = MapProvider();

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const Text(
                  '마이페이지',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'NanumSquareNeo-Bold',
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              _showImagePickerDialog(context);
            },
            child: profile == null
                ? Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person,
                      size: 35.0,
                      color: Colors.grey[600],
                    ),
                  )
                : ClipOval(
                    child: Image.network(
                      profile!,
                      width: 70,
                      height: 70,
                    ),
                  ),
          ),
          const SizedBox(height: 5.0),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  name ?? '',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'NanumSquareNeo-Bold',
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(width: 4.0),
                GestureDetector(
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateProfilePage()),
                          ).then((v) {
                      _loadFromStorage();
                    })
                  },
                  child: Image.asset(
                    'assets/images/edit.png',
                    width: 20.0,
                    height: 20.0,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
              onPressed: () {
                context.read<FriendProvider>().getLatestList();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FriendPage()),
                );
              },
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: const Text(
                    '친구',
                    style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 1.5,
                        fontSize: 16,
                        fontFamily: 'NanumSquareNeo-Bold'),
                  ),
                ),
              )),
          const Divider(color: Color(0xFFD9D9D9)),
          TextButton(
            onPressed: () {},
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: const Text(
                  '전체 지도',
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 1.5,
                    fontSize: 16,
                    fontFamily: 'NanumSquareNeo-Bold',
                  ),
                ),
              ),
            ),
          ),
          const Divider(color: Color(0xFFD9D9D9)),
          TextButton(
            onPressed: () {},
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: const Text(
                  '이용약관',
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 1.5,
                    fontSize: 16,
                    fontFamily: 'NanumSquareNeo-Bold',
                  ),
                ),
              ),
            ),
          ),
          const Divider(color: Color(0xFFD9D9D9)),
          TextButton(
            onPressed: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  print(accToken);
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
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: const Text(
                  '버전',
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 1.5,
                    fontSize: 16,
                    fontFamily: 'NanumSquareNeo-Bold',
                  ),
                ),
              ),
            ),
          ),
          const Divider(color: Color(0xFFD9D9D9)),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: const Text(
                  '로그아웃',
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 1.5,
                    fontSize: 16,
                    fontFamily: 'NanumSquareNeo-Bold',
                  ),
                ),
              ),
            ),
          ),
          const Divider(color: Color(0xFFD9D9D9)),
          TextButton(
            onPressed: () {
              const storage = FlutterSecureStorage();
              storage.deleteAll();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: const Text(
                  '탈퇴하기',
                  style: TextStyle(
                    letterSpacing: 1.5,
                    color: Colors.red,
                    fontSize: 16,
                    fontFamily: 'NanumSquareNeo-Bold',
                  ),
                ),
              ),
            ),
          ),
          const Divider(color: Color(0xFFD9D9D9)),
          const SizedBox(
            height: 50.0,
          ),
        ],
      ),
    );
  }

  void _showImagePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text('사진 보관함'),
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
