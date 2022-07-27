import 'package:flutter/material.dart';

class BottomAppButtonContainer extends StatelessWidget {
  final Widget child;
  const BottomAppButtonContainer({ Key key, @required this.child }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
          top: 10,
          bottom: 19,
          right: 24,
          left: 24,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.04),
              offset: Offset(1, 0),
              blurRadius: 12,
            )
          ]
        ),
        child: child,
      );
  }
}