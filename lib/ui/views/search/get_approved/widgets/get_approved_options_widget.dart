import 'package:flutter/material.dart';

class GetApprovedOptionsWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function onTap;
  const GetApprovedOptionsWidget({
    Key key,
    @required this.title,
    @required this.subtitle,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: Color(0xFFF4F5F6),
          shape: BoxShape.circle,
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: Text(
          title ?? '',
          style: TextStyle(
            color: Color(0xFF231F20),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      subtitle: Text(
        subtitle ?? '',
        style: TextStyle(
          color: Color(0xFF717171),
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
