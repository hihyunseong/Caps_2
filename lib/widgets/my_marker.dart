import 'dart:io';

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
            color: Colors.green[100],
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 5,
            ),
          ),
          child: Center(
            // 이미지 파일이 있으면 원형이미지로 표시
            child: imagePath != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.network(
                      imagePath!,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  )
                : Image.asset(
                    category.iconPath,
                    width: 40,
                    height: 40,
                  ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              color: Colors.black,
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
