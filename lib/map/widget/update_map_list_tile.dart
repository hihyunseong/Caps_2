import 'package:caps_2/common/utils/app_util.dart';
import 'package:caps_2/models/map_model.dart';
import 'package:caps_2/provider/map_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateMapListTile extends StatelessWidget {
  final MapModel mapModel;
  final Function() onTap;
  final int memberId;

  const UpdateMapListTile({
    super.key,
    required this.mapModel,
    required this.onTap,
    required this.memberId,
  });

  @override
  Widget build(BuildContext context) {
    final memberOwnerId =
        mapModel.isSharedMap ? mapModel.sharedOwnerId : mapModel.ownerId;

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: mapModel.color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [               
                (mapModel.isSharedMap && memberId == memberOwnerId) ||
                        !mapModel.isSharedMap
                   
                    ? InkWell(
                        onTap: onTap,
                        child: Image.asset(
                          'assets/images/edit.png',
                          color: Colors.white,
                          width: 20,
                          height: 20,
                        ),
                      )
                    : const SizedBox(),
                InkWell(
                  onTap: () {
                    _showDialog(context);
                  },
                  child: Image.asset(
                    'assets/images/exit.png',
                    color: Colors.white,
                    width: 20,
                    height: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 3),
            Row(
              children: [
                Expanded(
                  flex: 15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            mapModel.mapName,
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: 'NanumSquareNeo-Bold',
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 8),
                          mapModel.friends.isNotEmpty
                              ? Image.asset(
                                  'assets/images/person.png',
                                  width: 10,
                                  height: 10,
                                  color: Colors.white,
                                )
                              : Image.asset(
                                  'assets/images/person2.png',
                                  width: 10,
                                  height: 10,
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
                        '최근 작성 ${AppUtil.getTimeAgo(mapModel.selectedDate)}',
                        style: const TextStyle(
                          fontSize: 10,
                          fontFamily: 'NanumSquareNeo-Bold',
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const Flexible(
                  flex: 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.person_2_outlined,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text(
            '맵 나가기',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            '맵을 나가시겠어요?\n맵을 나가면 소비 기록을 더 이상 볼 수 없어요.',
            style: TextStyle(
              fontSize: 11,
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text(
                '취소',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text(
                '나가기',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                context.read<MapProvider>().deleteMapModel(mapModel);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
