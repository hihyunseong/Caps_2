import 'package:caps_2/enums/map_status.dart';
import 'package:caps_2/map/my_map.dart';
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
        onLongPress: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('확인'),
                content: Text('${mapModel.mapName}을 삭제하시겠습니까?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('취소'),
                  ),
                  TextButton(
                    onPressed: () async {
                      final mapProvider = context.read<MapProvider>();
                      await mapProvider.deleteMapModel(mapModel);

                      Navigator.of(context).pop();

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('삭제되었습니다.'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    child: const Text('삭제'),
                  ),
                ],
              );
            },
          );
        },
        child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.purple[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Text(
                        mapModel.mapName,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Text(
                        mapModel.location.description!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 93, 93, 93),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                if (mapModel.friends.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        mapModel.friends[0],
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 93, 93, 93),
                        ),
                      ),
                      Icon(
                        Icons.person,
                        color: Colors.black,
                        size: 20,
                      ),
                    ],
                  )
              ],
            )
            // child: Row(
            //   children: [
            //     Expanded(
            //       flex: 1,
            //       child: Text(
            //         mapModel.mapName,
            //         style: const TextStyle(
            //             fontSize: 16, fontWeight: FontWeight.bold),
            //       ),
            //     ),
            //     if (mapModel.friends.isNotEmpty)
            //       Expanded(
            //         flex: 1,
            //         child: Text(
            //           mapModel.friends[0],
            //           style: const TextStyle(
            //               fontSize: 16, fontWeight: FontWeight.bold),
            //         ),
            //       ),
            //     Expanded(
            //       flex: 1,
            //       child: Text(
            //         mapModel.location.description!,
            //         style: const TextStyle(
            //             fontSize: 16, fontWeight: FontWeight.bold),
            //         overflow: TextOverflow.ellipsis,
            //       ),
            //     ),
            //   ],
            // ),
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
}
