import 'dart:convert';

import 'package:caps_2/auth/bloc/sign_up_bloc.dart';
import 'package:caps_2/login.dart';
import 'package:caps_2/vo/UrlUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

bool _isObscure = true;

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
        title: Align(
          alignment: FractionalOffset(0.4, 0),
          child: Text('약관 동의'),
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
                  text: '핀콕 서비스 이용을 위해 \n',
                  style: TextStyle(
                    fontFamily: 'NanumSquareNeo',
                    fontSize: 18.0,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '이용약관',
                      style: TextStyle(
                        fontFamily: 'NanumSquareNeo',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '에 동의해주세요.',
                      style: TextStyle(
                        fontFamily: 'NanumSquareNeo',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.0),
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
                              _marketingChecked = _allChecked;
                            });
                          },
                          checkColor: Colors.white,
                          activeColor: Color(0xFFFF6F61),
                        ),
                        Text(
                          '전체 동의',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontFamily: 'NanumSquareNeo-bold',                 
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
                            fontSize: 12.0,
                            fontFamily: 'NanumSquareNeo',
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
                            fontSize: 12.0,
                            fontFamily: 'NanumSquareNeo',
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
                            fontSize: 12.0,
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
                                _marketingChecked =
                                    false; // 개별 체크 해제 시 전체동의 체크 해제
                              }
                            });
                          },
                          checkColor: Colors.white,
                          activeColor: Color(0xFFFF6F61),
                        ),
                        Text(
                          '앱 푸시 및 마케팅/이벤트 수신 동의(선택)',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 140.0),
              ElevatedButton(
                onPressed: _ageChecked && _serviceChecked && _privacyChecked
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupFormPage()),
                        );
                      }
                    : null, // 필수 약관을 모두 동의한 경우에만 버튼 활성화
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
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
  const SignupFormPage({super.key});

  @override
  State<SignupFormPage> createState() => _SignupFormPageState();
}

class _SignupFormPageState extends State<SignupFormPage> {
  String _selectedCountryCode = '+82';

  // Map<String, String> _countryCodes = {

  // };

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  Future<http.Response> _registerUser() async {
    final url = Uri.http('${UrlUtil.url}:8080','/api/v1/members/register');

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
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _dobController.dispose();
    _phoneController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: FractionalOffset(0.4, 0),
          child: Text('본인 인증'),
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
                  text: '본인 확인을 위해 \n',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '인증',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '을 진행해 주세요.',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: "이름",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
                onChanged: (value) {},
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: '주민등록번호 앞자리',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    '-',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  // 검은 점 동그라미 6개
                  ...List.generate(
                    6,
                    (index) {
                      return Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.only(left: 10),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.24,
                    child: DropdownButtonFormField<String>(
                      value: _selectedCountryCode,
                      onChanged: (value) {
                        setState(() {
                          _selectedCountryCode = value!;
                        });
                      },
                      items: <String>['+82', '+1', '+86', '+91']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child: TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        hintText: '휴대폰 번호 (- 제외)',
                        border: OutlineInputBorder(),
                      ),
                      // keyboardType: TextInputType.phone,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 172),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InformationPage(
                        userName: _nameController.text,
                        phone: _phoneController.text,
                      ),
                    ),
                  );
                },
                child: Text('다음', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  backgroundColor: Color(0xFFFF6F61),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 회원 정보 입력
class InformationPage extends StatefulWidget {
  const InformationPage({
    super.key,
    required this.userName,
    required this.phone,
  });

  final String userName;
  final String phone;

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  TextEditingController _idController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

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

  Future<void> showSignUpSuccessDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text(
            "가입 성공",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          // contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "핀콕 가입을 축하드립니다!",
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
                child: const Text(
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

  void showSignUpFailureDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text(
            "가입 실패",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          // contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 1),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "비밀번호가 일치하지 않습니다.",
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
                child: const Text(
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
    return BlocProvider(
      create: (context) => SignUpBloc(),
      child: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          state.mapOrNull(
            success: (state) async {
              await showSignUpSuccessDialog();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            failure: (state) {
              showSignUpFailureDialog();
            },
          );
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Align(
                alignment: FractionalOffset(0.4, 0),
                child: Text('회원 정보 입력'),
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
                        text: '가입을 위해 \n',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '정보',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: '를 입력해 주세요.',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _idController,
                      decoration: InputDecoration(
                        hintText: "아이디(이메일)",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      onChanged: (value) {},
                    ),
                    SizedBox(height: 15),
                    TextField(
                      controller: _passwordController,
                      obscureText: _obscureTextPassword,
                      decoration: InputDecoration(
                        hintText: '비밀번호(8자리 이상)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureTextPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: _toggleVisibilityPassword,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      controller: _confirmPasswordController,
                      obscureText: _obscureTextConfirmPassword,
                      decoration: InputDecoration(
                        hintText: '비밀번호 재확인',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureTextConfirmPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: _toggleVisibilityConfirmPassword,
                        ),
                      ),
                    ),
                    SizedBox(height: 180),
                    ElevatedButton(
                      onPressed: () {
                        String password = _passwordController.text;
                        String confirmPassword =
                            _confirmPasswordController.text;

                        if (password == confirmPassword) {
                          context.read<SignUpBloc>().add(
                                SignUpEvent.started(
                                  email: _idController.text,
                                  password: password,
                                  userName: widget.userName,
                                  phone: widget.phone,
                                ),
                              );
                        } else {
                          showSignUpFailureDialog();
                        }
                      },
                      child:
                          Text('회원가입', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        backgroundColor: Color(0xFFFF6F61),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}