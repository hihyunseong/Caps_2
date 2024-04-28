import 'package:flutter/material.dart';
import 'package:caps_2/home.dart';

class ShareMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBackButton(context),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Positioned(
      top: 16,
      left: 16,
      child: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => Home()),
          );
        },
      ),
    );
  }
}
