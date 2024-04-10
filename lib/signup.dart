import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '회원가입을 위해 약관에 동의해주세요.',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              '약관 내용.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // 사용자가 약관에 동의하면 회원가입 절차를 진행
                _showConfirmationDialog(context);
              },
              child: Text('약관에 동의합니다'),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                // 사용자가 약관에 동의하지 않으면 이전 페이지로 돌아감
                Navigator.pop(context);
              },
              child: Text('약관에 동의하지 않습니다'),
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('약관 동의 확인'),
          content: Text('약관에 동의하시겠습니까?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _completeSignup(context);
              },
              child: Text('동의'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('취소'),
            ),
          ],
        );
      },
    );
  }

  void _completeSignup(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignupFormPage()),
    );
  }
}

class SignupFormPage extends StatefulWidget {
  @override
  _SignupFormPageState createState() => _SignupFormPageState();
}

class _SignupFormPageState extends State<SignupFormPage> {
  String _selectedCountry = '대한민국'; // 초기값은 대한민국으로 설정
  String _selectedGender = ''; // 선택된 성별 초기값은 없음

  Map<String, String> _countryCodes = {
    '대한민국': '+82',
    '미국': '+1',
    '영국': '+44',
  };

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  void _completeSignup(BuildContext context) {
    _registerUser().then((response) {
      print(response.body);
    });
  }

  Future<http.Response> _registerUser() async {
    final url = Uri.http('43.202.127.16:8080','/api/v1/members/register');

    final response = await http.post(
      url,
      headers: {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'email': _idController.text,
        'password': _passwordController.text,
        'username': _nameController.text,
        'phone': _phoneController.text,
      }),
    );

    return response;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('.'),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _inputBox(context, [
              _inputField(context, _idController, Icons.person, '아이디'),
              SizedBox(height: 8.0),
              Divider(height: 2, color: Colors.grey),
              _inputField(context, _passwordController, Icons.lock, '비밀번호', isPassword: true),
            ]),
            SizedBox(height: 8.0),
            _inputBox(context, [
              _inputField(context, _nameController, Icons.person_outline, '이름'),
              SizedBox(height: 8.0),
              Divider(height: 2, color: Colors.grey),
              _inputField(context, _dobController, Icons.calendar_today, '생년월일 8자리'),
              SizedBox(height: 8.0),
              Divider(height: 2, color: Colors.grey),
              _genderSelection(context),
              SizedBox(height: 10.0),
              Divider(height: 2, color: Colors.grey),
              _countryCodeDropdown(context),
              SizedBox(height: 8.0),
              _inputField(context, _phoneController, Icons.phone, '휴대전화번호'),
            ]),
            SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                // 회원가입 절차를 완료하고 다음 단계로 진행
                // 회원가입 정보를 서버에 전송하고 홈 화면으로 이동
              },
              child: Text('인증요청'),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                // 회원가입 버튼이 클릭되었을 때의 동작을 정의
                _completeSignup(context);
              },
              child: Text('회원가입'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputBox(BuildContext context, List<Widget> children) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.transparent),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
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

  Widget _genderSelection(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 1.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _GenderOption(
            gender: '남자',
            onSelect: (selectedGender) {
              setState(() {
                _selectedGender = selectedGender;
              });
            },
            isSelected: _selectedGender == '남자',
          ),
          _GenderOption(
            gender: '여자',
            onSelect: (selectedGender) {
              setState(() {
                _selectedGender = selectedGender;
              });
            },
            isSelected: _selectedGender == '여자',
          ),
          _GenderOption(
            gender: '선택안함',
            onSelect: (selectedGender) {
              setState(() {
                _selectedGender = selectedGender;
              });
            },
            isSelected: _selectedGender == '선택안함',
          ),
        ],
      ),
    );
  }

  Widget _countryCodeDropdown(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedCountry,
      onChanged: (String? newValue) {
        setState(() {
          _selectedCountry = newValue!;
        });
      },
      items: _countryCodes.keys.map((String country) {
        return DropdownMenuItem<String>(
          value: country,
          child: Row(
            children: [
              Text(country),
              SizedBox(width: 8.0),
              Text(
                _countryCodes[country]!,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _GenderOption extends StatefulWidget {
  final String gender;
  final Function(String) onSelect;
  final bool isSelected;

  const _GenderOption({
    required this.gender,
    required this.onSelect,
    required this.isSelected,
  });

  @override
  _GenderOptionState createState() => _GenderOptionState();
}

class _GenderOptionState extends State<_GenderOption> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onSelect(widget.gender);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: widget.isSelected ? Colors.transparent : Colors.transparent,
          border: Border.all(
            color: widget.isSelected ? Colors.black : Colors.transparent,
          ),
        ),
        child: Text(
          widget.gender,
          style: TextStyle(
            color: widget.isSelected ? Colors.black : Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SignupPage(),
  ));
}
