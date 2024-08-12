import 'package:caps_2/models/map_model.dart';
import 'package:flutter/material.dart';

class MapSelectListTile extends StatelessWidget {
  final MapModel mapModel;
  final Function()? onTap;
  final bool isSelected;

  const MapSelectListTile({super.key, required this.mapModel, this.onTap, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: mapModel.color,
            borderRadius: BorderRadius.circular(10),
            border: isSelected ? Border.all(color: Colors.black, width: 2) : null,
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
                                mapModel.friends.length.toString(),
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
                      '최근 작성 ${_getTimeAgo(mapModel.selectedDate)}',
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
        ),
      ),
    );
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