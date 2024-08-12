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

  @override
  String toString() {
    switch (this) {
      case Category.food:
        return '식사';
      case Category.cafe:
        return '카페';
      case Category.alcohol:
        return '주류';
      case Category.photo:
        return '사진';
      case Category.shopping:
        return '쇼핑';
      case Category.gift:
        return '선물';
      case Category.culture:
        return '문화생활';
      case Category.accommodations:
        return '숙소';
      case Category.mart:
        return '마트';
      case Category.flower:
        return '꽃';
      case Category.medicine:
        return '의료';
      case Category.tip:
        return '팁';
      case Category.beauty:
        return '미용';
      case Category.transport:
        return '교통';
      case Category.etc:
        return '기타';
    }
  }

  static Icon getIcon(String category) {
    switch (category) {
      case '식사':
        return const Icon(
          Icons.restaurant,
          size: 36,
        );
      case '카페':
        return const Icon(
          Icons.local_cafe,
          size: 36,
        );
      case '주류':
        return const Icon(
          Icons.local_bar,
          size: 36,
        );
      case '사진':
        return const Icon(
          Icons.camera_alt,
          size: 36,
        );
      case '쇼핑':
        return const Icon(
          Icons.shopping_cart,
          size: 36,
        );
      case '선물':
        return const Icon(
          Icons.card_giftcard,
          size: 36,
        );
      case '문화생활':
        return const Icon(
          Icons.restaurant,
          size: 36,
        );
      case '숙소':
        return const Icon(
          Icons.local_cafe,
          size: 36,
        );
      case '마트':
        return const Icon(
          Icons.local_bar,
          size: 36,
        );
      case '꽃':
        return const Icon(
          Icons.camera_alt,
          size: 36,
        );
      case '의료':
        return const Icon(
          Icons.shopping_cart,
          size: 36,
        );
      case '팁':
        return const Icon(
          Icons.card_giftcard,
          size: 36,
        );
      case '미용':
        return const Icon(
          Icons.add,
          size: 36,
        );
      case '교통':
        return const Icon(
          Icons.card_giftcard,
          size: 36,
        );
      case '기타':
        return const Icon(
          Icons.add,
          size: 36,
        );
      default:
        return const Icon(Icons.add);
    }
  }
}