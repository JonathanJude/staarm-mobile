import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HostInfoRowWidget extends StatelessWidget {
  final String title;
  final String text;
  final String icon;
  const HostInfoRowWidget({
    Key key,
    @required this.text,
    @required this.title,
    @required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: SvgPicture.asset(
              icon,
            ),
          ),

          // Container(
          //   padding: EdgeInsets.all(10),
          //   decoration: BoxDecoration(
          //     shape: BoxShape.circle,
          //     color: Color(0xFFF4F5F6),
          //   ),
          // ),

          SizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? '',
                  style: TextStyle(
                    color: Color(0xFF231F20),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  text ?? '',
                  style: TextStyle(
                    color: Color(0xFF757D8A),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
