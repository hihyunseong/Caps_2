import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class FindPw2 extends StatefulWidget {
  @override
  _FindPw2State createState() => _FindPw2State();
}

class _FindPw2State extends State<FindPw2> {
  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  bool _passwordsMatch = true;
  bool _isPasswordLongEnough = true;

  void _toggleVisibilityPassword() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }

  void _toggleVisibilityConfirmPassword() {
    setState(() {
      _obscureTextConfirmPassword = !_obscureTextConfirmPassword;
    });
  }

  void _onConfirm() {
    setState(() {
      _passwordsMatch =
          _passwordController.text == _confirmPasswordController.text;
      _isPasswordLongEnough = _passwordController.text.length >= 8;
    });

    if (!_passwordsMatch) {
      _showDialog(
        title: "비밀번호 재설정 실패",
        content: "비밀번호가 일치하지 않습니다.",
      );
    } else if (!_isPasswordLongEnough) {
      _showDialog(
        title: "비밀번호 재설정 실패",
        content: "비밀번호는 8자리 이상이어야 합니다.",
      );
    } else {
      _showDialog(
        title: "비밀번호 재설정 성공",
        content: "비밀번호를 재설정하였습니다.",
      );
    }
  }

  void _showDialog({required String title, required String content}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                content,
                style: TextStyle(
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "확인",
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: FractionalOffset(0.4, 0),
          child: Text('비밀번호 재설정'),
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
                  text: '앞으로 사용하실 \n',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '새로운 비밀번호',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '를 입력해 주세요.',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              TextField(
                controller: _passwordController,
                obscureText: _obscureTextPassword,
                decoration: InputDecoration(
                  hintText: '새로운 비밀번호',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureTextPassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: _toggleVisibilityPassword,
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _confirmPasswordController,
                obscureText: _obscureTextConfirmPassword,
                decoration: InputDecoration(
                  hintText: '새로운 비밀번호 재입력',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureTextConfirmPassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: _toggleVisibilityConfirmPassword,
                  ),
                ),
              ),
              SizedBox(height: 325.0),
              ElevatedButton(
                onPressed: _onConfirm,
                child: Text(
                  '비밀번호 재설정',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  backgroundColor: Color(0xFFFF6F61),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
