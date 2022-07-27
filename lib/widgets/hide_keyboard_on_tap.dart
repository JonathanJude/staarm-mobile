import 'package:flutter/material.dart';

class HideKeyboardOnTap extends StatelessWidget {
  final Widget child;
  const HideKeyboardOnTap({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: child,
    );
  }
}
