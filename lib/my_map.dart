import 'package:flutter/material.dart';

class MyMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('나의 맵'),
      ),
      body: Center(
        child: Text(
          '나의 맵.',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
