import 'package:caps_2/common/enums/map_status.dart';
import 'package:caps_2/models/daily_expense.dart';
import 'package:caps_2/provider/map_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

// 맵 목록에서 맵 선택했을 때 보이는 첫 페이지 위젯
class ExpensesPanel extends StatelessWidget {
  final PanelController panelController;
  final GoogleMapController googleMapController;

  const ExpensesPanel({
    super.key,
    required this.panelController,
    required this.googleMapController,
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
                      ? () => mapProvider.changeShareMapStatus(MapStatus.mapList)
                      : () => mapProvider.changeMyMapStatus(MapStatus.mapList),
                  icon: const Icon(Icons.arrow_back)),
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          mapModel.mapName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontFamily: 'NanumSquareNeo-Bold',
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (mapModel.friends.isNotEmpty)
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/person.png',
                                width: 16,
                                height: 16,
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
                  onTap: () async {
                    panelController.animatePanelToPosition(0.3);

                    if (mapModel.isSharedMap) {
                      mapProvider.setDailyExpense(dailyExpense);
                      mapProvider.changeShareMapStatus(MapStatus.dailyExpense);
                    } else {
                      mapProvider.setDailyExpense(dailyExpense);
                      mapProvider.changeMyMapStatus(MapStatus.dailyExpense);
                    }
                    await mapProvider.setIndexForDate(dailyExpense.tourDay);
                    mapProvider.fitAllMarkers(googleMapController);
                  },
                  leading: const CircleAvatar(),
                  title: Text(
                    DateFormat('yyyy년 M월 d일').format(dailyExpense.tourDay),
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'NanumSquareNeo-Bold',
                    ),
                  ),
                  trailing: Text(
                    '₩${NumberFormat('###,###').format(dailyExpense.totalAmount)}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'NanumSquareNeo-Bold',
                      color: Colors.red,
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