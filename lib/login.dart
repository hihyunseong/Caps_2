import 'package:flutter/material.dart';
import 'signup.dart';
import 'find_id.dart';
import 'find_pw.dart';
import 'Home.dart'; 

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _passwordController = TextEditingController();

  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
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
    );
  }

  Widget _header(context) {
    return Column(
      children: [
        Text(
          "핀콕",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: "아이디",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            prefixIcon: Icon(Icons.person),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
            hintText: "비밀번호",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            prefixIcon: Icon(Icons.lock),
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
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            // 로그인 버튼이 클릭되었을 때 Home.dart 페이지로 이동
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()), 
            );
          },
          child: Text(
            "로그인",
            style: TextStyle(fontSize: 20),
          ),
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            padding: EdgeInsets.symmetric(vertical: 16),
          ),
        )
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
      child: Text("회원가입"),
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
      child: Text("아이디 찾기"),
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
      child: Text("비밀번호 찾기"),
    );
  }
}
