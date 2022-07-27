import 'package:flutter/material.dart';

class AppVerticalDivider extends StatelessWidget {
  const AppVerticalDivider({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: 20,
      width: 1,
      decoration: BoxDecoration(color: Colors.grey),
    );
  }
}
