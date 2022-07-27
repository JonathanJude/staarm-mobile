import 'package:flutter/material.dart';

class UnderlineFlatButton extends StatelessWidget {
  final Function onTap;
  final String text;
  const UnderlineFlatButton({ Key key, @required this.onTap, @required this.text, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(text,
        style: TextStyle(
          color: Colors.black,
          decoration: TextDecoration.underline,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
    );
  }
}