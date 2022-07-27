import 'package:flutter/material.dart';

class InfoContainer extends StatelessWidget {
  final String text;
  const InfoContainer({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      margin: EdgeInsets.symmetric(
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            color: Color(0xFF757D8A),
            size: 18,
          ),
          SizedBox(width: 10),
          Flexible(
            child: Text(
              text ?? '',
              style: TextStyle(
                color: Color(0xFF757D8A),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
