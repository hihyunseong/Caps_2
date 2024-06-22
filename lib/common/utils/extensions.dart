import 'dart:ui';

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
