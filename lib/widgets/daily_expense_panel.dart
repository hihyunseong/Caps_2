import 'dart:io';

import 'package:caps_2/enums/map_status.dart';
import 'package:caps_2/provider/map_provider.dart';
import 'package:caps_2/widgets/expense_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DailyExpensePanel extends StatelessWidget {
  const DailyExpensePanel({super.key});

  @override
  Widget build(BuildContext context) {
    final mapProvider = Provider.of<MapProvider>(context, listen: false);
    final mapModel = context.read<MapProvider>().mapModel!;
    final dailyExpense = context.read<MapProvider>().dailyExpense!;

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
        children: [
          Column(
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
                      onPressed: mapModel.isSharedMap
                          ? () => mapProvider
                              .changeShareMapStatus(MapStatus.expenses)
                          : () =>
                              mapProvider.changeMyMapStatus(MapStatus.expenses),
                      icon: const Icon(Icons.arrow_back)),
                  Text(
                    mapModel.mapName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'NanumSquareNeo-Bold',
                    ),
                  ),
                  const IconButton(
                    onPressed: null,
                    icon: Icon(Icons.more_vert, color: Colors.transparent),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Text(
                '${DateFormat('yyyy년 M월 d일').format(dailyExpense.tourDay)}의 소비 기록',
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'NanumSquareNeo-Bold',
                ),
              ),
              const Divider(
                color: Colors.black,
                thickness: 2,
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Expanded(
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: dailyExpense.expenses.length + 1,
              itemBuilder: (context, index) {
                if (index > dailyExpense.expenses.length - 1) {
                  return const SizedBox(height: 300);
                } else {
                  final expense = dailyExpense.expenses[index];
                  return Stack(
                    children: [
                      if (index == 0)
                        Positioned(
                          left: 35,
                          top: 40,
                          bottom: 0,
                          child: Container(
                            width: 2,
                            color: Colors.grey[300],
                          ),
                        ),
                      if (index != dailyExpense.expenses.length - 1 &&
                          index != 0)
                        Positioned(
                          left: 35,
                          top: 0,
                          bottom: 0,
                          child: Container(
                            width: 2,
                            color: Colors.grey[300],
                          ),
                        ),
                      ExpenseTile(
                        expense: expense,
                        onTap: () {
                          mapProvider.setExpense(expense);
                          mapModel.isSharedMap
                              ? mapProvider.changeShareMapStatus(
                                  MapStatus.expenseDetails)
                              : mapProvider
                                  .changeMyMapStatus(MapStatus.expenseDetails);
                        },
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
