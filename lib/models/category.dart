import 'package:flutter/material.dart';

enum Category {
  food('식사', 'assets/images/category/food.png', Icons.restaurant),
  cafe('카페', 'assets/images/category/coffee.png', Icons.local_cafe),
  alcohol('주류', 'assets/images/category/beer.png', Icons.local_bar),
  photo('사진', 'assets/images/category/photo.png', Icons.camera_alt),
  shopping('쇼핑', 'assets/images/category/shopping.png', Icons.shopping_cart),
  gift('선물', 'assets/images/category/gift.png', Icons.card_giftcard),
  plus('편집', 'assets/images/category/plus.png', Icons.add),
  ;

  final String text;
  final String iconPath;
  final IconData icon;

  const Category(this.text, this.iconPath, this.icon);
}
