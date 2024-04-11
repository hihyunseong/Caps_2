import 'package:flutter/material.dart';

enum Category {
  sleep('숙소', Icons.hotel),
  transport('교통', Icons.directions_car),
  food('식사', Icons.restaurant),
  shopping('쇼핑', Icons.shopping_cart),
  etc('기타', Icons.category);

  final String text;
  final IconData icon;

  const Category(this.text, this.icon);
}
