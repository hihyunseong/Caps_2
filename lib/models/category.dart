import 'package:flutter/material.dart';

enum Category {
  food('식사', 'assets/images/category/food.png', Icons.restaurant),
  cafe('카페', 'assets/images/category/coffee.png', Icons.local_cafe),
  alcohol('주류', 'assets/images/category/beer.png', Icons.local_bar),
  photo('사진', 'assets/images/category/photo.png', Icons.camera_alt),
  shopping('쇼핑', 'assets/images/category/shopping.png', Icons.shopping_cart),
  gift('선물', 'assets/images/category/gift.png', Icons.card_giftcard),

  culture('문화생활', 'assets/images/category/culture.png', Icons.restaurant),
  accommodations('숙소', 'assets/images/category/accommodations.png', Icons.local_cafe),
  mart('마트', 'assets/images/category/mart.png', Icons.local_bar),
  flower('꽃', 'assets/images/category/flower.png', Icons.camera_alt),
  medicine('의료', 'assets/images/category/medicine.png', Icons.shopping_cart),
  tip('팁', 'assets/images/category/tip.png', Icons.card_giftcard),
  beauty('미용', 'assets/images/category/beauty.png', Icons.add),
  transport('교통', 'assets/images/category/transport.png', Icons.card_giftcard),
  etc('기타', 'assets/images/category/etc.png', Icons.add);

  final String text;
  final String iconPath;
  final IconData icon;

  const Category(this.text, this.iconPath, this.icon);
}
