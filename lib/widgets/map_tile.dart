import 'package:caps_2/common/enums/map_status.dart';
import 'package:caps_2/models/map_model.dart';
import 'package:caps_2/provider/map_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapTile extends StatelessWidget {
  final MapModel mapModel;
  final Function(LatLng? latLng) gotoLocation;
  final Function(DateTime date) changeDate;

  const MapTile({
    super.key,
    required this.mapModel,
    required this.gotoLocation,
    required this.changeDate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: InkWell(
        onTap: () => _changeMapModel(context),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: mapModel.color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          mapModel.mapName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontFamily: 'NanumSquareNeo-Bold',
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8),
                        mapModel.friends.isNotEmpty
                            ? Image.asset(
                                'assets/images/person.png',
                                width: 14,
                                height: 14,
                                color: Colors.white,
                              )
                            : Image.asset(
                                'assets/images/person2.png',
                                width: 14,
                                height: 14,
                                color: Colors.white,
                              ),
                        const SizedBox(width: 4),
                        mapModel.friends.isNotEmpty
                            ? Text(
                                (mapModel.friends.length).toString(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'NanumSquareNeo-Bold',
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                '1',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'NanumSquareNeo-Bold',
                                  color: Colors.white,
                                ),
                              ),
                      ],
                    ),
                    Text(
                      '최근 작성 ${_getTimeAgo(mapModel.lastExpensesUpdate ?? mapModel.selectedDate)}',
                      style: const TextStyle(
                        fontSize: 10,
                        fontFamily: 'NanumSquareNeo-Bold',
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    mapModel.friends.isNotEmpty
                        ? const Icon(
                            Icons.people_alt,
                            color: Colors.white,
                          )
                        : const Icon(
                            Icons.person_2_outlined,
                            color: Colors.white,
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _changeMapModel(BuildContext context) async {
    // map model 변경
    final mapProvider = context.read<MapProvider>();

    await mapProvider.loadMapModel(mapModel);
    // 지도 위치 이동
    final LatLng? latLng = mapProvider.tourExpenses.isEmpty
        ? mapModel.latLng
        : mapProvider.tourExpenses.first.latLng;

    await gotoLocation(latLng);
    changeDate(mapModel.selectedDate);

    mapModel.isSharedMap
        ? mapProvider.changeShareMapStatus(MapStatus.expenses)
        : mapProvider.changeMyMapStatus(MapStatus.expenses);
  }

  String _getTimeAgo(DateTime inputDate) {
    DateTime now = DateTime.now().toUtc();
    Duration diff = now.difference(inputDate.toUtc());

    if (diff.inMinutes < 1) {
      return '방금';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes}분 전';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}시간 전';
    } else if (diff.inDays < 30) {
      return '${diff.inDays}일 전';
    } else if (diff.inDays < 365) {
      int months = (diff.inDays / 30).floor();
      return '$months개월 전';
    } else {
      int years = (diff.inDays / 365).floor();
      return '$years년 전';
    }
  }
}
