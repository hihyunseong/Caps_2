import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ShareMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('공유맵'),
      ),
      body: Center(
        child: Text(
          '공유맵.',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
