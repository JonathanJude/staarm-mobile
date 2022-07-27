import 'package:flutter/material.dart';

class AppDivider extends StatelessWidget {
  final Color color;
  final double thickness;
  final double height;

  const AppDivider({Key key, this.color, this.thickness = 1.2, this.height})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color ?? Color(0xFFE7E7E8),
      thickness: thickness,
      height: height,
    );
  }
}
