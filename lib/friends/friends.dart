import 'dart:convert';

import 'package:caps_2/vo/FriendInfo.dart';
import 'package:caps_2/vo/FriendRequest.dart';
import 'package:flutter/material.dart';
import 'package:caps_2/my.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';



class Friends extends StatefulWidget {

  @override
  _FriendsState createState() => _FriendsState();
}


class _FriendsState extends State<Friends> {
  bool isBottomBarVisible = false;

  static final String memberUrl = "43.202.127.16:8080";   /// 멤버 서비스 API
  static final String friendUrl = "43.202.127.16:8081";   /// 친구 서비스 API

  static String friendEmail = "";       /// 검색한 유저 이메일
  static String friendName = "";        /// 검색한 유저 이름
  static List<FriendInfo> friendList = []; /// 친구 목록
  static List<FriendRequest> requestList = []; /// 친구 요청 목록

  static final storage = FlutterSecureStorage();

  String? idx;
  String? email;
  String? name;
  String? accToken;
  String? refToken;

  void _read() async{
    idx = await storage.read(key: 'idx');
    email = await storage.read(key: 'email');
    name = await storage.read(key: 'name');
    accToken = await storage.read(key: 'accToken');
    refToken = await storage.read(key: 'refToken');
  }

  void _updateFriend(String email, String name){
    setState(() {
      friendEmail = email;
      friendName = name;
    });
  }

  void _showMessage(String message){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _searchFriend(String email) async{         ///   친구 추가하기 위해서 이메일로 멤버 검색하는 함수
    final url = Uri.http(memberUrl,'/api/v1/members/search/'+email);

    final response = await http.get(
      url,
      headers: {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + accToken.toString(),
      }
    );
    if(response.statusCode == 200){
      print(response.body);
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      _updateFriend(responseData['email'], responseData['name']);
    }else{
      print(response.body);
      _showMessage(response.body);
      _updateFriend("", "");
    }
    print(friendName + " " + friendEmail);
  }

  void _getFriendsList() async{
    final url = Uri.http(friendUrl,'/api/v1/friends/list');

    final response = await http.get(
        url,
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
        }
    );
    if(response.statusCode == 200){
      print(response.body);
      final List<dynamic> responseData = jsonDecode(response.body);
      friendList = responseData.map((data) => FriendInfo.fromJson(data)).toList();
    }else{
      _showMessage(response.body);
      print(response.body);
    }
  }

  void _getFriendRequest() async{
    final url = Uri.http(friendUrl,'/api/v1/friends/request');

    final response = await http.get(
        url,
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
        }
    );
    if(response == 200){
      print(response.body);
      final List<dynamic> responseData = jsonDecode(response.body);
      requestList = responseData.map((data) => FriendRequest.fromJson(data)).toList();
    }else{
      print(response.body);
      _showMessage(response.body);
    }
  }

  static Future<http.Response> _acceptFriend(String friendIdx) async {
    final url = Uri.http(friendUrl, '/api/v1/members/accept' + friendIdx);

    final response = await http.get(
        url,
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
        }
    );
    return response;
  }

  static Future<http.Response> _declineFriend(String friendIdx) async {
    final url = Uri.http(friendUrl,'/api/v1/members/decline/' + friendIdx);

    final response = await http.get(
        url,
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
        }
    );
    return response;
  }

  @override
  void initState(){
    _getFriendsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyPage()),
            );
          },
        ),
        title: null,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 20.0),
                Text(
                  '친구 리스트',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              '친구를 초대해보세요!',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: '친구 검색',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 30.0),
          Expanded(
            child: Container(
              alignment: Alignment.topCenter,
              child: Row(
                children: [
                  SizedBox(width: 20.0),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 30.0,
                        backgroundColor: Colors.pink,
                        child: GestureDetector(
                          onTap: () {
                            _showSlidingPanel2(context);
                            setState(() {
                              isBottomBarVisible = !isBottomBarVisible;
                            });
                          },
                        ),
                      ),
                      Text('홍길동',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          Expanded(
            child: Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(bottom: 50.0),
              child: FloatingActionButton(
                onPressed: () {
                  _showSlidingPanel(context);
                  setState(() {
                    isBottomBarVisible = !isBottomBarVisible;
                  });
                },
                child: Icon(Icons.add),
                backgroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 친구추가 하단바
  void _showSlidingPanel(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => SlidingUpPanel(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        minHeight: 1500,
        maxHeight: MediaQuery.of(context).size.height* 0.7,
        panel: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '친구 추가',
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              SizedBox(height: 5.0),
              Text(
                '이메일로 친구를 추가해보세요!',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: '이메일 작성',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  ElevatedButton(
                    onPressed: () {
                      _searchFriend(_emailController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      backgroundColor: Colors.black,
                    ),
                    child: Text(
                      '검색',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.0),
              Text(friendName,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 맵리스트 하단바
  void _showSlidingPanel2(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => SlidingUpPanel(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        minHeight: 1500,
        maxHeight: MediaQuery.of(context).size.height * 0.7,
        panel: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'xxx의 맵 리스트',
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              SizedBox(height: 5.0),
              Text(
                'xxx님과 함께하는 맵 리스트에요!',
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _inputField(BuildContext context, TextEditingController controller, IconData icon, String hintText, {bool isPassword = false}) {
  return TextField(
    controller: controller,
    obscureText: isPassword,
    decoration: InputDecoration(
      hintText: hintText,
      prefixIcon: Icon(icon),
      border: InputBorder.none,
    ),
  );
}
