import 'package:caps_2/models/category.dart';
import 'package:flutter/material.dart';

class MyMarker extends StatelessWidget {
  final int index;
  final Category category;
  final String? imagePath;

  const MyMarker({
    super.key,
    required this.index,
    required this.category,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.transparent,
            ),
          ),
          child: Center(
            child: Image.asset(
              category.iconPath,
              width: 50,
              height: 50,
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            width: 17,
            height: 17,
            decoration: const BoxDecoration(
              color: Color(0xFFFFD700),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                index.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
