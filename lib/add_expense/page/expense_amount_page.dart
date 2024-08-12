import 'package:caps_2/add_expense/page/map_select_page.dart';
import 'package:caps_2/add_expense/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

// 금액입력
class ExpenseAmountPage extends StatefulWidget {
  final LatLng location;
  final DateTime date;

  const ExpenseAmountPage({
    super.key,
    required this.location,
    required this.date,
  });

  @override
  State<ExpenseAmountPage> createState() => _ExpenseAmountPageState();
}

class _ExpenseAmountPageState extends State<ExpenseAmountPage> {
  String _inputValue = '';
  bool _decimalPressed = false;
  final TextEditingController _controller = TextEditingController();

  void _addToInput(String value) {
    setState(() {
      if (value == '.' && !_decimalPressed) {
        _inputValue += value;
        _decimalPressed = true;
      } else if (value != '.') {
        _inputValue += value;
      }
      // 세 자리마다 쉼표(,) 추가
      _inputValue = _formatNumber(_inputValue);
    });
  }

  String _formatNumber(String value) {
    if (value.isEmpty) return ''; // 빈 문자열이면 그대로 반환
    final formatter = NumberFormat('#,###'); // 세 자리마다 쉼표(,) 추가하는 포맷
    return formatter.format(double.parse(value.replaceAll(',', '')));
  }

  void _clearInput() {
    setState(() {
      _inputValue = '';
      _decimalPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          '금액 입력',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w900,
            fontFamily: 'NanumSquareNeo-Bold',
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 15),
          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          //   decoration: BoxDecoration(
          //     color: Colors.grey[300],
          //     borderRadius: BorderRadius.circular(5),
          //   ),
          //   child: const Text(
          //     'KRW',
          //     style: TextStyle(fontWeight: FontWeight.bold),
          //   ),
          // ),
          const SizedBox(height: 45),

          _buildInputField(),
          const SizedBox(height: 25),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.2,
                ),
                itemCount: 12,
                itemBuilder: (context, index) {
                  if (index == 9) {
                    return _buildEmptyButton();
                  } else if (index == 11) {
                    return _buildClearButton();
                  } else {
                    return index == 10
                        ? _buildNumberButton('0')
                        : _buildNumberButton((index + 1).toString());
                  }
                },
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                title: '다음',
                height: 70,
                color: (_inputValue == '') ? Colors.red[100]! : Colors.red[300]!,
                onTap: () {
                  if (_inputValue == '') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('금액을 입력해주세요.'),
                      ),
                    );
                    return;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapSelectPage(
                        amount: double.parse(_inputValue.replaceAll(',', '')),
                        location: widget.location,
                        date: widget.date,
                        expenseLocationName: _controller.text,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInputField() {
    String money;

    if (_inputValue.isEmpty) {
      money = '₩ 0';
    } else {
      money = '₩ $_inputValue';
    }

    return Text(
      money,
      style: TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.w900,
        fontFamily: 'NanumSquareNeo-Bold',
        color: _inputValue.isEmpty ? Colors.grey : Colors.black,
      ),
    );
  }

  Widget _buildEmptyButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        surfaceTintColor: MaterialStateProperty.all(Colors.transparent),
        shadowColor: MaterialStateProperty.all(Colors.transparent),
        foregroundColor: MaterialStateProperty.all(Colors.black),
      ),
      child: const Text(''),
    );
  }

  Widget _buildNumberButton(String value) {
    return ElevatedButton(
      onPressed: () => _addToInput(value),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        surfaceTintColor: MaterialStateProperty.all(Colors.transparent),
        shadowColor: MaterialStateProperty.all(Colors.transparent),
        foregroundColor: MaterialStateProperty.all(Colors.black),
      ),
      child: Text(
        value,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w900,
          fontFamily: 'NanumSquareNeo-Bold',
        ),
      ),
    );
  }

  Widget _buildActionButton(dynamic value) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: ElevatedButton(
          onPressed: () {
            if (value == '.' && !_decimalPressed) {
              _addToInput(value);
              setState(() {
                _decimalPressed = true;
              });
            }
          },
          child: value is String ? Text(value) : value,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildClearButton() {
    return ElevatedButton(
      onPressed: () {
        if (_inputValue.isNotEmpty) {
          setState(
            () {
              if (_inputValue.endsWith('.')) {
                _decimalPressed = false;
              }
              _inputValue = _inputValue.substring(0, _inputValue.length - 1);

              _inputValue = _formatNumber(_inputValue);
            },
          );
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        surfaceTintColor: MaterialStateProperty.all(Colors.transparent),
        shadowColor: MaterialStateProperty.all(Colors.transparent),
        foregroundColor: MaterialStateProperty.all(Colors.black),
      ),
      child: const Icon(
        Icons.backspace_outlined,
        size: 26,
      ),
    );
  }
}
