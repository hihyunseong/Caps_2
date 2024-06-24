import 'dart:convert';

import 'package:caps_2/vo/UrlUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import 'auth/signup.dart';
import 'find_id.dart';
import 'find_pw.dart';
import 'home.dart';

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

  Future<void> _write(
      Map<String, dynamic> responseData, Map<String, String> header) async {
    await storage.write(key: 'idx', value: responseData['idx'].toString());
    await storage.write(key: 'email', value: responseData['email']);
    await storage.write(key: 'name', value: responseData['name']);
    await storage.write(key: 'profile', value: responseData['profile']);
    await storage.write(key: 'accToken', value: header['authorization']);
    await storage.write(key: 'refToken', value: header['x-refresh-token']);
  }

  void Login(BuildContext context) async{
    _loginUser().then((response) {
      print(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200){
        final Map<String, dynamic> responseData = 
            jsonDecode(utf8.decode(response.bodyBytes));
        final Map<String, String> header = response.headers;
        _write(responseData, header).then((_) { 
          // write  data
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
          );
        });
      } else{
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

  void KakaoLogin() async{
    if (await isKakaoTalkInstalled()) {
      print('카카오 설치 됨');
      try {
        await UserApi.instance.loginWithKakaoTalk();
        print('카카오톡으로 로그인 성공');
        User user;
        try {
          user = await UserApi.instance.me();
          print(user);
        } catch (error) {
          print('사용자 정보 요청 실패 $error');
          return;
        }
        _kakaoLoginUser(user).then((response){
          print(utf8.decode(response.bodyBytes));
          if (response.statusCode == 200) {
            final Map<String, dynamic> responseData = 
                jsonDecode(utf8.decode(response.bodyBytes));
            final Map<String, String> header = response.headers;
            _write(responseData, header).then((_) { 
              // write  data
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
                            MaterialPageRoute(
                                builder: (context) => const Home()),
                          );
                        },
                        child: Text('확인'),
                      ),
                    ],
                  );
                },
              );
            });
          }
        });
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');
        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          await UserApi.instance.loginWithKakaoAccount();
          print('카카오계정으로 로그인 성공');
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
        }
      }
    } else {
      print('카카로 설치 안됨');
      try {
        await UserApi.instance.loginWithKakaoAccount();
        print('카카오계정으로 로그인 성공');
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  }

  Future<void> NaverLogin() async{
    final NaverLoginResult result = await FlutterNaverLogin.logIn();

    if (result.status == NaverLoginStatus.loggedIn){
      print('Logged IN');
      _naverLoginUser(result).then((response){
        print(utf8.decode(response.bodyBytes));
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = 
              jsonDecode(utf8.decode(response.bodyBytes));
          final Map<String, String> header = response.headers;
          _write(responseData, header).then((_) { 
            // write  data
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    '로그인',
                  ),
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
            );
          });
        }
      });
    } else {
      print("Naver Login Failed");
    }
  }

  Future<void> GoogleLogin() async{
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if(googleSignInAccount != null){
      print("구글 로그인");
      _googleLoginUser(googleSignInAccount).then((response){
        print(utf8.decode(response.bodyBytes));
        if(response.statusCode == 200) {
          final Map<String, dynamic> responseData = 
              jsonDecode(utf8.decode(response.bodyBytes));
          final Map<String, String> header = response.headers;
          _write(responseData, header).then((_) { 
            // write  data
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
            );
          });
        }
      });
    } else {
      print("구글 로그인 실패");
    }
  }

  Future<http.Response> _loginUser() async {
    final url = Uri.http('${UrlUtil.url}:8080', '/api/v1/members/login');

    final response = await http.post(
      url,
      headers: {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        'email': _idController.text,
        'password': _passwordController.text,
      }),
    );

    return response;
  }

  Future<http.Response> _kakaoLoginUser(User user) async{
    final url = Uri.http('${UrlUtil.url}:8080', '/api/v1/oauth/login/kakao');
    String? email = user.kakaoAccount?.email;
    String? name = user.kakaoAccount?.profile?.nickname;
    String? profile = user.kakaoAccount?.profile?.profileImageUrl;
    final response = await http.post(url,
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'email': email,
          'name' : name,
          'profile': profile,
        }));
    return response;
  }

  Future<http.Response> _naverLoginUser(NaverLoginResult result) async {
    final url = Uri.http('${UrlUtil.url}:8080', '/api/v1/oauth/login/naver');
    String email = result.account.email;
    String name = result.account.name;
    String profile = result.account.profileImage;
    final response = await http.post(url,
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'email': email,
          'name': name,
          'profile': profile,
        }));
    return response;
  }

  Future<http.Response> _googleLoginUser(GoogleSignInAccount account) async {
    final url = Uri.http('${UrlUtil.url}:8080', '/api/v1/oauth/login/google');
    String? email = account.email;
    String? name = account.displayName;
    String? profile = account.photoUrl;
    final response = await http.post(url,
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'email': email,
          'name': name,
          'profile': profile,
        }));
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
        SizedBox(height: 50),
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
                text: ' 꽂아 소비를 기록하다.',
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 247, 152, 143),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 48),
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
            hintStyle: const TextStyle(
              fontFamily: 'NanumSquareNeo-Bold',
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
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
            hintStyle: const TextStyle(
            fontFamily: 'NanumSquareNeo-Bold',
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: Colors.grey),
            ),
            fillColor: Colors.white,
            filled: true,
            suffixIcon: IconButton(
              icon: Icon(
                _isObscure ? Icons.visibility_off : Icons.visibility,
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
            style: TextStyle(
                fontSize: 20, 
                fontFamily: 'NanumSquareNeo-Bold', 
                color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
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
                  fontSize: 14.5,
                  fontFamily: 'NanumSquareNeo-Bold',
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
        SizedBox(height: 16),
        Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: KakaoLogin,
              child: Image.asset("assets/images/kakao.png", width: 44),
            ),
            TextButton(
              onPressed: NaverLogin,
              child: Image.asset("assets/images/naver.png", width: 44),
            ),
            TextButton(
              onPressed: GoogleLogin,
              child: Image.asset("assets/images/google.png", width: 44),
            )
          ],
        )),
        SizedBox(
          height: 80,
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
      child: Text(
        "회원가입",
        style: TextStyle(
          fontFamily: 'NanumSquareNeo-Bold',
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
      child: Text(
        "아이디 찾기",
        style: TextStyle(
          fontFamily: 'NanumSquareNeo-Bold',
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
      child: Text(
        "비밀번호 찾기",
        style: TextStyle(
          fontFamily: 'NanumSquareNeo-Bold',
          color:Colors.black,
        ),
      ),
    );
  }
}