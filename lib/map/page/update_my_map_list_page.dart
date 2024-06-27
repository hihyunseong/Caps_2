import 'package:caps_2/map/page/update_map_page.dart';
import 'package:caps_2/map/widget/update_map_list_tile.dart';
import 'package:caps_2/provider/map_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateMyMapListPage extends StatelessWidget {
  const UpdateMyMapListPage({
    super.key,
    required this.memberId,
  });

  final String memberId;

  @override
  Widget build(BuildContext context) {
    final mapProvider = context.watch<MapProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          '마이맵 목록 편집',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w900,
            fontFamily: 'NanumSquareNeo-Bold',
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          itemCount: mapProvider.newMyMapList.length,
          itemBuilder: (context, index) {
            return UpdateMapListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateMapPage(
                      mapModel: mapProvider.newMyMapList[index],
                    ),
                  ),
                );
              },
              mapModel: mapProvider.newMyMapList[index],
              memberId: int.parse(memberId),
            );
          },
        ),
      ),
    );
  }
}
