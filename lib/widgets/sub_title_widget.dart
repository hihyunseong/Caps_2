import 'package:flutter/material.dart';

class SubTitleWidget extends StatelessWidget {
  final String subTitle;
  final double fontSize;
  final bool isRequired;

  const SubTitleWidget({
    super.key,
    required this.subTitle,
    this.fontSize = 18.0,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isRequired) {
      return Row(
        children: [
          Text(
            subTitle,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w900,
              fontFamily: 'NanumSquareNeo-Bold',
            ),
          ),
          Text(
            '*',
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w900,
              fontFamily: 'NanumSquareNeo-Bold',
              color: const Color(0xFFFF6F61),
            ),
          ),
        ],
      );
    }
    return Text(
      subTitle,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w900,
        fontFamily: 'NanumSquareNeo-Bold',
      ),
    );
  }
}
