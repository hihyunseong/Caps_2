import 'dart:io';

import 'package:caps_2/models/daily_expense.dart';
import 'package:caps_2/models/map_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpensesSheet extends StatelessWidget {
  final MapModel mapModel;
  final DailyExpense dailyExpense;

  const ExpensesSheet({
    super.key,
    required this.mapModel,
    required this.dailyExpense,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height * 0.5,
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                mapModel.mapName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                DateFormat('yyyy년 M월 d일').format(dailyExpense.tourDay),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: ListView.builder(
                itemCount: dailyExpense.expenses.length,
                itemBuilder: (context, index) {
                  final expense = dailyExpense.expenses[index];

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey[200],
                      child:
                          // 이미지 있으면 표시 하고 아니면 아이콘
                          expense.imagePath != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.file(
                                    File(expense.imagePath!),
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Icon(expense.category.icon),
                    ),
                    title: Text(
                      expense.content,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      expense.memo,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Text(
                      '${NumberFormat('###,###').format(expense.amount.toInt())}원',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
