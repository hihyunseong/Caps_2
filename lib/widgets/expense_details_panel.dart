import 'dart:io';

import 'package:caps_2/common/enums/map_status.dart';
import 'package:caps_2/models/expense.dart';
import 'package:caps_2/provider/map_provider.dart';
import 'package:caps_2/widgets/expense_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// expenses_panel > daily_expense_panel 후 상세기록 보는 페이지 위젯
class ExpenseDetailsPanel extends StatelessWidget {
  const ExpenseDetailsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final mapProvider = Provider.of<MapProvider>(context, listen: false);
    final mapModel = mapProvider.mapModel!;
    final expense = mapProvider.expense!;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFC4C4C4),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          const SizedBox(height: 10.0),

          // title
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                // onPressed: mapModel.isSharedMap
                //     ? () =>
                //         mapProvider.changeShareMapStatus(MapStatus.mapDetails)
                //     : () => mapProvider.changeMyMapStatus(MapStatus.mapDetails),
                onPressed: mapModel.isSharedMap
                    ? () => mapProvider.changeShareMapStatus(MapStatus.dailyExpense)
                    : () => mapProvider.changeMyMapStatus(MapStatus.dailyExpense),
                icon: const Icon(Icons.arrow_back),
              ),
                  const IconButton(
                    onPressed: null,
                    icon: Icon(Icons.more_vert, color: Colors.transparent),
                  ),
                ],
              ),

              // expense details
              const SizedBox(height: 10),
              Expanded(
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _locationAndDateSelectWidget(expense),
                        const SizedBox(height: 20),
                        _priceWidget(expense),
                        const SizedBox(height: 20),
                        ExpenseTile(
                          expense: expense,
                          imageHeight: 200,
                          imageWidth: 200,
                          onTap: () {},
                        ),
                        Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '댓글',
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'NanumSquareNeo-Bold',
                          ),
                        ),
                        SizedBox(height: 100.0),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }

  Widget _locationAndDateSelectWidget(Expense expense) {
    return Row(
      children: [
        Text(
          '📍',
          style: TextStyle(fontSize: 16.0),
        ),
        Text(
          expense.expenseLocationName,
          style: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w900,
            fontFamily: 'NanumSquareNeo-Bold',
          ),
        ),
        const Text(
          ' 에서',
          style: TextStyle(
            fontSize: 12.0,
            fontFamily: 'NanumSquareNeo-Bold',
            color: Colors.grey,
          ),
        ),
        const SizedBox(width: 2),
        Text(
          '🗓',
          style: TextStyle(fontSize: 16.0),
        ),
        
        InkWell(
          onTap: () {
            // _editRecord();
            // _selectDate(context);
          },
          child: Row(
            children: [
              Text(
                '${DateFormat('yyyy.MM.dd').format(expense.date)}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'NanumSquareNeo-Bold',
                ),
              ),
              // IconButton(
              //   onPressed: () {
              //     _selectDate(context);
              //   },
              //   icon: const Icon(Icons.calendar_today),
              // ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        const Text(
          '의 소비 기록',
          style: TextStyle(
            fontSize: 12.0,
            fontFamily: 'NanumSquareNeo-Bold',
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _priceWidget(Expense expense) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/frame.png',
          width: 24.0, 
          height: 24.0, 
        ),
        const SizedBox(width: 8.0),
        Text(
          '₩${_formatNumber(expense.amount.toString())}',
          style: const TextStyle(
            fontSize: 16.0,
            fontFamily: 'NanumSquareNeo-Bold',
            color: Colors.red,
            ),
          ),
        ],
      );
    }

  String _formatNumber(String value) {
    if (value.isEmpty) return ''; // 빈 문자열이면 그대로 반환
    final formatter = NumberFormat('#,###'); // 세 자리마다 쉼표(,) 추가하는 포맷
    return formatter.format(double.parse(value.replaceAll(',', '')));
  }
}
