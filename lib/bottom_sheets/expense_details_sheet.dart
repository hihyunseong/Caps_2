import 'dart:io';

import 'package:caps_2/models/expense.dart';
import 'package:caps_2/models/map_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseDetailsSheet extends StatelessWidget {
  final MapModel mapModel;
  final Expense expense;

  const ExpenseDetailsSheet({
    super.key,
    required this.mapModel,
    required this.expense,
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
          Text(
            mapModel.mapName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      expense.category.text,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      DateFormat('yyyy.MM.dd mm:ss').format(expense.date),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 93, 93, 93),
                      ),
                    ),
                    trailing: Text(
                      '${NumberFormat('###,###').format(expense.amount.toInt())}원',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (expense.imagePath != null)
                    Image.file(
                      File(expense.imagePath!),
                      width: 170,
                      height: 170,
                      fit: BoxFit.cover,
                    ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      expense.content,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      expense.memo,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
