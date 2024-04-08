import 'package:flutter/material.dart';
import 'find_pw3.dart'; 

class FindPw2 extends StatefulWidget {
  @override
  _FindPwState createState() => _FindPwState();
}

class _FindPwState extends State<FindPw2> {
  String _selectedCountryCode = '+82'; // 기본값은 +82

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('본인 확인'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildNameField(),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: _buildCountryCodeDropdown(),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: _buildPhoneNumberField(),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: _buildVerificationButton(context),
                ),
              ],
            ),
            SizedBox(height: 10),
            _buildVerificationCodeField(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 확인 버튼 클릭 시 find_pw3.dart 페이지로 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FindPw3()), 
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text('확인'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: '이름',
        prefixIcon: Icon(Icons.person),
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildCountryCodeDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedCountryCode,
      onChanged: (value) {
        setState(() {
          _selectedCountryCode = value!;
        });
      },
      items: <String>['+82', '+1', '+86', '+91'] // 여기에 필요한 국가 코드를 추가하세요
          .map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.flag),
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildPhoneNumberField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: '휴대폰 번호',
        prefixIcon: Icon(Icons.phone),
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.phone,
    );
  }

  Widget _buildVerificationButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // 인증 기능 구현
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Text('인증'),
      ),
    );
  }

  Widget _buildVerificationCodeField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: '인증번호 숫자 6자리',
        prefixIcon: Icon(Icons.lock),
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      maxLength: 6,
    );
  }
}
