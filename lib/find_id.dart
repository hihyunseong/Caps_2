import 'package:flutter/material.dart';

class FindId extends StatefulWidget {
  @override
  _FindIdState createState() => _FindIdState();
}

class _FindIdState extends State<FindId> {
  String _selectedCountryCode = '+82';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: FractionalOffset(0.4, 0),
          child: Text('아이디 찾기'),
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
                  text: '가입 시 등록한 \n',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '휴대폰 번호',
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
              Row(
                children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.2, // 드롭다운 버튼의 너비를 조정합니다.
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
                    decoration: InputDecoration(
                      hintText: '휴대폰 번호 (- 제외)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ],
            ),
            SizedBox(height: 420),
            ElevatedButton(
              onPressed: () {},
              child: Text('아이디 찾기', style: TextStyle(color: Colors.white)),
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
