import 'package:caps_2/common/utils/app_util.dart';
import 'package:caps_2/models/map_model.dart';
import 'package:caps_2/provider/map_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class UpdateMapListTile extends StatefulWidget {
  final MapModel mapModel;
  final Function() onTap;

  const UpdateMapListTile({
    super.key,
    required this.mapModel,
    required this.onTap,
  });

  @override
  State<UpdateMapListTile> createState() => _UpdateMapListTileState();
}

class _UpdateMapListTileState extends State<UpdateMapListTile> {
  int? memberId;

  @override
  void initState() {
    super.initState();
    _loadFromStorage();
  }

  Future<void> _loadFromStorage() async {
    const storage = FlutterSecureStorage();

    final loadIdx = await storage.read(key: 'idx');
    setState(() {
      memberId = int.parse(loadIdx ?? '0');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: widget.mapModel.color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                memberId == widget.mapModel.ownerId
                    ? InkWell(
                        onTap: widget.onTap,
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
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.mapModel.mapName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontFamily: 'NanumSquareNeo-Bold',
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 8),
                          widget.mapModel.friends.isNotEmpty
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
                          widget.mapModel.friends.isNotEmpty
                              ? Text(
                                  (widget.mapModel.friends.length + 1)
                                      .toString(),
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
                        '최근 작성 ${AppUtil.getTimeAgo(widget.mapModel.selectedDate)}',
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
          title: Text(
            '맵 나가기',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            '맵을 나가시겠어요?\n맵을 나가면 소비 기록을 더 이상 볼 수 없어요.',
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('취소',
                style: TextStyle(
                    color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('나가기',
                style: TextStyle(
                    color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
              onPressed: () {
                context.read<MapProvider>().deleteMapModel(widget.mapModel);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
