import 'package:flutter/material.dart';
import 'package:staarm_mobile/styles/colors.dart';

class ProfileItem extends StatelessWidget {
  final String title;
  final Function onTap;
  final bool isBold;
  const ProfileItem({
    Key key,
    this.title,
    this.onTap,
    this.isBold = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Text(
              title ?? '',
              style: TextStyle(
                color: isBold ? Color(0xFF231F20) : AppColors.grey5,
                fontSize: 14,
              ),
            ),
          ),
          Divider(
            thickness: 1.2,
            color: Color(0xFFF1F2F3),
          ),
        ],
      ),
    );
  }
}
