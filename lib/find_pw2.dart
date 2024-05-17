import 'package:flutter/material.dart';

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
    });
    if (_passwordsMatch) {
      // 비밀번호 재설정 성공 창을 띄우는 코드를 여기에 추가합니다.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("비밀번호 재설정 성공",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold, 
              ),
              textAlign: TextAlign.center, 
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("비밀번호를 재설정하였습니다.",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center, 
                ),
                SizedBox(height: 10), 
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text("확인",
                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
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
              if (!_passwordsMatch)
                Text(
                  '비밀번호가 일치하지 않습니다.',
                  style: TextStyle(color: Colors.red),
                  textAlign: TextAlign.center, 
                ),
            ],
          ),
        ),
      ),
    );
  }
}
