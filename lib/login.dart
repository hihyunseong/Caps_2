import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;import 'package:flutter/material.dart';
import 'home.dart';
import 'signup.dart';
import 'find_id.dart';
import 'find_pw.dart'; 

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _idController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final storage = FlutterSecureStorage();

  bool _isObscure = true;

  Future<void> _write(Map<String, dynamic> responseData, Map<String, String> header) async{
    await storage.write(key: 'idx', value: responseData['idx'].toString());
    await storage.write(key: 'email', value: responseData['email']);
    await storage.write(key: 'name', value: responseData['name']);
    await storage.write(key: 'profile', value: responseData['profile']);
    await storage.write(key: 'accToken', value: header['authorization']);
    await storage.write(key: 'refToken', value: header['x-refresh-token']);
  }

  void Login(BuildContext context) {
    _loginUser().then((response) {
      print(response.body);
      if(response.statusCode == 200){
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final Map<String, String> header = response.headers;
        _write(responseData, header).then((_){// write  data
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('로그인'),
              content: Text(responseData['name']! + '님 환영합니다.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
                    );
                  },
                  child: Text('확인'),
                ),
              ],
            );
          },
        );});
      }else{
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(response.body),
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
    });
  }

  Future<http.Response> _loginUser() async {
    final url = Uri.http('43.202.127.16:8080','/api/v1/members/login');

    final response = await http.post(
      url,
      headers: {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'email': _idController.text,
        'password': _passwordController.text,
      }),
    );

    return response;
  }

  @override
Widget build(BuildContext context) {
  return SafeArea(
    child: Scaffold(
      resizeToAvoidBottomInset: true, 
      body: SingleChildScrollView( 
        child: Container(
          margin: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _inputField(context),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _signup(context),
                  SizedBox(width: 20),
                  _findID(context),
                  SizedBox(width: 20),
                  _forgotPassword(context),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}


  Widget _header(context) {
  return Column(
    children: [
      SizedBox(height: 55),
      Row(
        children: [
          SizedBox(width: 97),
          Image.asset(
            'assets/images/frame.png',
            width: 55, 
            height: 80, 
          ),
          SizedBox(width: 13), 
          Image.asset(
            'assets/images/pinkok.png', 
            width: 85, 
            height: 60, 
          ),
        ],
      ),
      RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '지도에 ',
              style: TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 247, 152, 143),
              ),
            ),
            TextSpan(
              text: '핀',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFFFF6F61),
              ),
            ),
            TextSpan(
              text: '을 ', 
              style: TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 247, 152, 143), 
              ),
            ),
            TextSpan(
              text: '콕',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFFFF6F61), 
              ),
            ),
            TextSpan(
              text: ' 찍어 소비를 기록하다.', 
              style: TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 247, 152, 143), 
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 18),
    ],
  );
}

Widget _inputField(context) {
  bool _idEntered = _idController.text.isNotEmpty;
  bool _passwordEntered = _passwordController.text.isNotEmpty;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      TextField(
        controller: _idController,
        decoration: InputDecoration(
          hintText: "아이디(이메일)",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey),
          ),
          fillColor: Colors.white,
          filled: true,
        ),
        onChanged: (value) {
          setState(() {}); // 텍스트 입력 변경 시 화면을 다시 그리기 위해 setState 호출
        },
      ),
      SizedBox(height: 5),
      TextField(
        controller: _passwordController,
        decoration: InputDecoration(
          hintText: "비밀번호",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey),
          ),
          fillColor: Colors.white,
          filled: true,
          suffixIcon: IconButton(
            icon: Icon(
              _isObscure ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            },
          ),
        ),
        obscureText: _isObscure,
        onChanged: (value) {
          setState(() {}); // 텍스트 입력 변경 시 화면을 다시 그리기 위해 setState 호출
        },
      ),
      SizedBox(height: 5),
      ElevatedButton(
        onPressed: _idEntered && _passwordEntered
            ? () {
                Login(context);
              }
            : null, // 입력되지 않은 경우 버튼을 비활성화
        child: Text(
          "로그인",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(vertical: 16),
          backgroundColor: _idEntered && _passwordEntered
              ? Color(0xFFFF6F61) 
              : Colors.grey, 
        ),
      ),
      SizedBox(height: 30),
      Row(
        children: [
          Container(
            width: 54, 
            height: 1,
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "SNS 계정으로 간편 로그인/가입하기",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: 53, 
            height: 1,
            color: Colors.grey,
          ),
        ],
      ),
    ],
  );
}


  Widget _signup(context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignupPage()),
        );
      },
      child: Text("회원가입",
        style: TextStyle(
          color: Colors.black,
      ),
    ),
  );
}

  Widget _findID(context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FindId()),
        );
      },
      child: Text("아이디 찾기",
        style: TextStyle(
          color: Colors.black,
      ),
    ),
  );
}

  Widget _forgotPassword(context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FindPw()),
        );
      },
      child: Text("비밀번호 찾기",
        style: TextStyle(
          color:Colors.black,
        ),
      ),
    );
  }
}

