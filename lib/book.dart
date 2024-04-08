import 'package:flutter/material.dart';

class Book extends StatefulWidget {
  @override
  _BookState createState() => _BookState();
}

class _BookState extends State<Book> {
  String _amount = '';
  String _paymentMethod = '현금';
  String _usage = '';
  String _selectedCategory = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('가계부'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: '금액',
              ),
              onChanged: (value) {
                setState(() {
                  _amount = value;
                });
              },
            ),
            SizedBox(height: 20.0),
            Text('지불 수단', style: TextStyle(fontSize: 18.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                  value: '현금',
                  groupValue: _paymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _paymentMethod = value.toString();
                    });
                  },
                ),
                Text('현금'),
                SizedBox(width: 20.0),
                Radio(
                  value: '카드',
                  groupValue: _paymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _paymentMethod = value.toString();
                    });
                  },
                ),
                Text('카드'),
              ],
            ),
            SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                labelText: '사용처',
              ),
              onChanged: (value) {
                setState(() {
                  _usage = value;
                });
              },
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildIconButton(Icons.hotel, '숙소', '숙소'),
                _buildIconButton(Icons.directions_car, '교통', '교통'),
                _buildIconButton(Icons.restaurant, '식사', '식사'),
                _buildIconButton(Icons.shopping_cart, '쇼핑', '쇼핑'),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _selectedCategory = '기타';
                        });
                      },
                      icon: Icon(Icons.category, size: _selectedCategory == '기타' ? 50 : 30),
                      iconSize: 30.0,
                    ),
                    Text('기타'),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        // 편집 버튼 동작 추가
                      },
                      icon: Icon(Icons.add),
                      iconSize: 30.0,
                    ),
                    Text('편집'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _selectedCategory);
              },
              child: Text('저장'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, String label, String category) {
    return Column(
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              _selectedCategory = category;
            });
          },
          icon: Icon(icon, size: _selectedCategory == category ? 50 : 30),
          iconSize: 30.0,
        ),
        Text(label),
      ],
    );
  }
}
