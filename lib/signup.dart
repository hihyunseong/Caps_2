import 'dart:convert';

import 'package:caps_2/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _allChecked = false; // 전체동의 체크 상태
  bool _ageChecked = false; // 만 14세 이상입니다 체크 상태
  bool _serviceChecked = false; // 서비스 이용 체크 상태
  bool _privacyChecked = false; // 개인정보 체크 상태 
  bool _marketingChecked = false; // 마케팅 체크 상태
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('약관동의')),
      ),
      body: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text.rich(
              TextSpan(
                text: '핀콕 서비스 이용을 위해 \n',
                style: TextStyle(
                  fontSize: 18.0,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '이용약관',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: '에 동의해주세요.',
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey),
              ),
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _allChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            _allChecked = value ?? false;
                            _ageChecked = _allChecked;
                            _serviceChecked = _allChecked; 
                            _privacyChecked = _allChecked;
                          
                          });
                        },
                        checkColor: Colors.white,
                        activeColor: Color(0xFFFF6F61),
                      ),
                      Text(
                        '전체동의',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: _ageChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            _ageChecked = value ?? false;
                            if (!_ageChecked && _allChecked) {
                              _allChecked = false; // 개별 체크 해제 시 전체동의 체크 해제
                            }
                          });
                        },
                        checkColor: Colors.white,
                        activeColor: Color(0xFFFF6F61),
                      ),
                      Text(
                        '만 14세 이상입니다. (필수)',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                   Row(
                    children: [
                      Checkbox(
                        value: _serviceChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            _serviceChecked = value ?? false;
                            if (!_serviceChecked && _allChecked) {
                              _allChecked = false; // 개별 체크 해제 시 전체동의 체크 해제
                            }
                          });
                        },
                        checkColor: Colors.white,
                        activeColor: Color(0xFFFF6F61),
                      ),
                      Text(
                        '서비스 이용약관 동의(필수)',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: _privacyChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            _privacyChecked = value ?? false;
                            if (!_privacyChecked && _allChecked) {
                              _allChecked = false; // 개별 체크 해제 시 전체동의 체크 해제
                            }
                          });
                        },
                        checkColor: Colors.white,
                        activeColor: Color(0xFFFF6F61),
                      ),
                      Text(
                        '개인정보 수집 및 이용 동의 (필수)',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: _marketingChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            _marketingChecked = value ?? false;
                            if (!_marketingChecked && _allChecked) {
                              _marketingChecked = true; // 개별 체크 해제 시 전체동의 체크 해제
                            }
                          });
                        },
                        checkColor: Colors.white,
                        activeColor: Color(0xFFFF6F61), 
                      ),
                      Text(
                        '앱 푸시 및 마케팅/이벤트 수신 동의(선택)',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 200.0),
          ElevatedButton(
            onPressed:  _ageChecked && _serviceChecked && _privacyChecked ? () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignupFormPage()),
              );
            } : null, // 필수 약관을 모두 동의한 경우에만 버튼 활성화
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0), 
              ),
              backgroundColor: Color(0xFFFF6F61),
              foregroundColor: Colors.white,
            ),
            child: Text('다음'),
            ),
          ],
        ),
      ),
    ),
  );
  }
}


  void _completeSignup(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignupFormPage()),
    );
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
        title: Text('Pinkok'),
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