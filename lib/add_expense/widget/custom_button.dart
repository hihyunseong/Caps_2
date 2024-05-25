import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final double height;
  final Color color;
  final Function()? onTap;

  const CustomButton({
    super.key,
    required this.title,
    required this.height,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(24.0),
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16.0,
              fontFamily: 'NanumSquareNeo-Bold',
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
