import 'package:flutter/material.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

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
              Navigator.pushNamed(context, '/map_view');
            },
          ),
          ListTile(
            title: const Text('목록'),
            onTap: () { 
            },
          ),
        ],
      ),
    );
  }
}
