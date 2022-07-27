import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' show TextStyle, FontWeight;

class AppTextStyles {
  AppTextStyles._();

  static TextStyle get cardLabel {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.black
    );
  }

  static TextStyle get toolInfo {
    return TextStyle(
      fontSize: 12,
      color: Color(0xFFB0B0B0)
    );
  }

  static TextStyle get socialLogin {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    );
  }

  static TextStyle get cta {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    );
  }

  static TextStyle get label {
    return TextStyle(
      fontSize: 10,
      color: Colors.black,
    );
  }

  static TextStyle get input {
    return TextStyle(
      fontSize: 14,
      color: Colors.black,
    );
  }
}
