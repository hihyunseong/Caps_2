import 'package:caps_2/bottom_sheets/expenses_sheet.dart';
import 'package:caps_2/bottom_sheets/map_details_sheet.dart';
import 'package:caps_2/models/daily_expense.dart';
import 'package:caps_2/models/map_model.dart';
import 'package:caps_2/provider/map_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MyMapSheet extends StatelessWidget {
  final MapModel mapModel;
  const MyMapSheet({
    super.key,
    required this.mapModel,
  });

  @override
  Widget build(BuildContext context) {
    final mapProvider = Provider.of<MapProvider>(context, listen: false);

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
          GestureDetector(
            onTap: () {
              // expenses details sheet
              _showMapDetailsSheet(context);
            },
            child: Container(
              color: Colors.transparent,
              child: Text(
                mapModel.mapName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              // shrinkWrap: true,
              itemCount: mapProvider.dailyExpenses.length,
              itemBuilder: (context, index) {
                final DailyExpense dailyExpense =
                    mapProvider.dailyExpenses[index];

                return ListTile(
                  onTap: () {
                    _showExpensesSheet(
                      context: context,
                      dailyExpense: dailyExpense,
                    );
                  },
                  leading: const CircleAvatar(),
                  title: Text(
                    DateFormat('yyyy년 M월 d일').format(dailyExpense.tourDay),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: Text(
                    '${NumberFormat('###,###').format(dailyExpense.totalAmount)}원',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  contentPadding: EdgeInsets.zero,
                );
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void _showExpensesSheet({
    required BuildContext context,
    required DailyExpense dailyExpense,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return ExpensesSheet(
          mapModel: mapModel,
          dailyExpense: dailyExpense,
        );
      },
    );
  }

  void _showMapDetailsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return MapDetailsSheet(
          mapModel: mapModel,
        );
      },
    );
  }
}
