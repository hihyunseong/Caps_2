import 'dart:ui';

import 'package:caps_2/common/enums/pay_method.dart';
import 'package:caps_2/models/category.dart';

extension StringColorExtensions on String {
  Color getColorFromString() {
    if (this == 'green') {
      return const Color.fromRGBO(47, 200, 84, 1.0);
    } else if (this == 'orange') {
      return const Color.fromRGBO(255, 185, 55, 1.0);
    } else if (this == 'purple') {
      return const Color.fromRGBO(124, 88, 175, 1);
    } else if (this == 'blue') {
      return const Color.fromRGBO(58, 91, 172, 1);
    } else {
      return const Color.fromRGBO(0, 0, 0, 1);
    }
  }

  Category toCategory() {
    final category = toUpperCase();
    switch (category) {
      case '식사':
        return Category.food;
      case '카페':
        return Category.cafe;
      case '주류':
        return Category.alcohol;
      case '사진':
        return Category.photo;
      case '쇼핑':
        return Category.shopping;
      case '선물':
        return Category.gift;
      case '문화':
        return Category.culture;
      case '숙소':
        return Category.accommodations;
      case '마트':
        return Category.mart;
      case '꽃':
        return Category.flower;
      case '의료':
        return Category.medicine;
      case '팁':
        return Category.tip;
      case '미용':
        return Category.beauty;
      case '교통':
        return Category.transport;
      default:
        return Category.etc;
    }
  }

  PayMethod toPayMethod() {
    final value = toUpperCase();
    switch (value) {
      case '신용카드':
        return PayMethod.creditCatd;
      case '체크카드':
        return PayMethod.checkCard;
      case '현금':
        return PayMethod.cash;
      case '계좌이체':
        return PayMethod.accountTransfer;
      default:
        return PayMethod.none;
    }
  }
}

extension ColorStringExtensions on Color {
  String getColorString() {
    if (this == const Color.fromRGBO(47, 200, 84, 1.0)) {
      return 'GREEN';
    } else if (this == const Color.fromRGBO(255, 185, 55, 1.0)) {
      return 'ORANGE';
    } else if (this == const Color.fromRGBO(124, 88, 175, 1)) {
      return 'PURPLE';
    } else if (this == const Color.fromRGBO(58, 91, 172, 1)) {
      return 'BLUE';
    } else {
      return 'OTHERS';
    }
  }
}
