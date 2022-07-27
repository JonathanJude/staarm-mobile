import 'package:flutter/material.dart';

import '../../../../styles/colors.dart';

class BookingAppBarIconButton extends StatelessWidget {
  final IconData icon;
  final Function onTap;
  final Color color;
  final Color iconColor;
  final double iconSize;
  final double padding;
  const BookingAppBarIconButton({
    Key key,
    @required this.icon,
    this.onTap,
    this.color,
    this.iconColor,
    this.iconSize,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.all(padding ?? 6),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: color ?? AppColors.grey2, shape: BoxShape.circle),
        child: Icon(
          icon,
          color: iconColor ?? AppColors.grey5,
          size: iconSize ?? 19,
        ),
      ),
    );
  }
}
