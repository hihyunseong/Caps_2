import 'package:caps_2/enums/map_status.dart';
import 'package:caps_2/models/daily_expense.dart';
import 'package:caps_2/provider/map_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ExpensesPanel extends StatelessWidget {
  const ExpensesPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mapProvider = Provider.of<MapProvider>(context, listen: false);
    final mapModel = context.read<MapProvider>().mapModel!;

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: mapModel.isSharedMap
                      ? () =>
                          mapProvider.changeShareMapStatus(MapStatus.mapList)
                      : () => mapProvider.changeMyMapStatus(MapStatus.mapList),
                  icon: const Icon(Icons.arrow_back)),
              GestureDetector(
                onTap: mapModel.isSharedMap
                    ? () =>
                        mapProvider.changeShareMapStatus(MapStatus.mapDetails)
                    : () => mapProvider.changeMyMapStatus(MapStatus.mapDetails),
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
              const IconButton(
                onPressed: null,
                icon: Icon(Icons.more_vert, color: Colors.transparent),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              // shrinkWrap: true,
              itemCount: mapProvider.dailyExpenses.length,
              itemBuilder: (context, index) {
                final DailyExpense dailyExpense =
                    mapProvider.dailyExpenses[index];

                return ListTile(
                  onTap: mapModel.isSharedMap
                      ? () {
                          mapProvider.setDailyExpense(dailyExpense);
                          mapProvider
                              .changeShareMapStatus(MapStatus.dailyExpense);
                        }
                      : () {
                          mapProvider.setDailyExpense(dailyExpense);
                          mapProvider.changeMyMapStatus(MapStatus.dailyExpense);
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
}
