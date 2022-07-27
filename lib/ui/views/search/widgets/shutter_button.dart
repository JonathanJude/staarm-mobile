import 'package:flutter/material.dart';

class ShuttterButton extends StatelessWidget {
  final Function onTap;
  const ShuttterButton({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(.4),
        ),
        child: Container(
          height: 54,
          width: 54,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(
                color: Colors.white.withOpacity(.4),
                width: 6,
              )),
        ),
      ),
    );
  }
}
