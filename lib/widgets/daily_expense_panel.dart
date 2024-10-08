import 'package:caps_2/common/enums/map_status.dart';
import 'package:caps_2/expense/view/expense_details_view.dart';
import 'package:caps_2/provider/map_provider.dart';
import 'package:caps_2/widgets/expense_tile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

// expenses_panel 에서 날짜 클릭 했을 때 보이는 페이지 위젯
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
                          ? () => mapProvider.changeShareMapStatus(MapStatus.expenses)
                          : () => mapProvider.changeMyMapStatus(MapStatus.expenses),
                      icon: const Icon(Icons.arrow_back)
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            mapModel.mapName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontFamily: 'NanumSquareNeo-Bold',
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (mapModel.friends.isNotEmpty)
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/person.png',
                                  width: 14,
                                  height: 14,
                                  color: const Color(0xFFAF55A6),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  (mapModel.friends.length).toString(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'NanumSquareNeo-Bold',
                                    color: const Color(0xFFAF55A6),
                                  ),
                                ),
                              ],
                            )
                          else
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/person2.png',
                                  width: 16,
                                  height: 16,
                                  color: const Color(0xFFF15B7C),
                                ),
                                const SizedBox(width: 4),
                                const Text(
                                  '1',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'NanumSquareNeo-Bold',
                                    color: const Color(0xFFF15B7C),
                                  ),
                                ),
                              ],
                            ),
                          ],
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
                    '${DateFormat('yyyy-MM-dd(EEE)','ko_KR').format(dailyExpense.tourDay)}의 소비 기록',
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'NanumSquareNeo-Bold',
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: 1,
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
                          if (mapModel.isSharedMap) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return ExpenseDetailsView(
                                      pinIdx: expense.pinIdx);
                                },
                              ),
                            );
                            return;
                          }
                          mapProvider
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
