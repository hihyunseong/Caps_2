import 'package:flutter/material.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('지도 페이지'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('지도 보기'),
            onTap: () {
              // TODO: 여기에 지도 보기 기능 추가
              Navigator.pushNamed(context, '/map_view');
            },
          ),
          ListTile(
            title: const Text('목록'),
            onTap: () {
              // TODO: 다른 목록 항목을 클릭했을 때의 동작 추가
            },
          ),
          // 다른 항목들을 필요에 따라 추가
        ],
      ),
    );
  }
}
