import 'dart:io';

import 'package:caps_2/bottom_sheets/expense_details_sheet.dart';
import 'package:caps_2/models/expense.dart';
import 'package:caps_2/models/map_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MapDetailsSheet extends StatelessWidget {
  final MapModel mapModel;

  const MapDetailsSheet({
    super.key,
    required this.mapModel,
  });

  List<Expense> get expenses => mapModel.expenses;

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
              child: ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  final expense = expenses[index];

                  return Column(
                    children: [
                      ListTile(
                        leading: InkWell(
                          onTap: () {
                            // expense details sheet
                            _showExpenseDetailsSheet(context, expense);
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            child: Icon(expense.category.icon),
                          ),
                        ),
                        title: Text(
                          expense.category.text,
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
                      ),
                      if (expense.imagePath != null)
                        Image.file(
                          File(expense.imagePath!),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          expense.content,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Divider(),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showExpenseDetailsSheet(
    BuildContext context,
    Expense expense,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return ExpenseDetailsSheet(
          mapModel: mapModel,
          expense: expense,
        );
      },
    );
  }
}
