import 'package:flutter/material.dart';

class AppButtonSpinner extends StatelessWidget {
  final Color color;
  final double size;

  const AppButtonSpinner({
    Key key,
    this.color = Colors.white,
    this.size = 21,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }
}
