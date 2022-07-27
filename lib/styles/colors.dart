import 'package:flutter/material.dart' show Color, MaterialColor;

const MaterialColor white = const MaterialColor(
  0xFFFFFFFF,
  const <int, Color>{
    50: const Color.fromRGBO(255, 255, 255, 0.1),
    100: const Color.fromRGBO(255, 255, 255, 0.2),
    200: const Color.fromRGBO(255, 255, 255, 0.3),
    300: const Color.fromRGBO(255, 255, 255, 0.4),
    400: const Color.fromRGBO(255, 255, 255, 0.5),
    500: const Color.fromRGBO(255, 255, 255, 0.6),
    600: const Color.fromRGBO(255, 255, 255, 0.7),
    700: const Color.fromRGBO(255, 255, 255, 0.8),
    800: const Color.fromRGBO(255, 255, 255, 0.9),
    900: const Color.fromRGBO(255, 255, 255, 1),
  },
);

const MaterialColor purple = const MaterialColor(
  0x2E1A63,
  const <int, Color>{
    50: const Color.fromRGBO(46, 26, 99, 0.1),
    100: const Color.fromRGBO(46, 26, 99, 0.2),
    200: const Color.fromRGBO(46, 26, 99, 0.3),
    300: const Color.fromRGBO(46, 26, 99, 0.4),
    400: const Color.fromRGBO(46, 26, 99, 0.5),
    500: const Color.fromRGBO(46, 26, 99, 0.6),
    600: const Color.fromRGBO(46, 26, 99, 0.7),
    700: const Color.fromRGBO(46, 26, 99, 0.8),
    800: const Color.fromRGBO(46, 26, 99, 0.69),
    900: const Color.fromRGBO(46, 26, 99, 1),
  },
);


class AppColors {
  AppColors._();

  static const Color primaryColor = Color(0xFF824DFF);
  static const Color appBackground = Color(0xFFFFFFFF);
  static const Color mainBlack = Color(0xFF231F20);
  static const Color mainPurple = Color(0xFF824DFF);
  static const Color mainGrey = Color(0xFF898989);
  static const Color grey5 = Color(0xFF757D8A);
  static const Color grey2 = Color(0xFFF1F2F3);

}
