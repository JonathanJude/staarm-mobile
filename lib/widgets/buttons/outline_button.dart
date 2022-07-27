import 'package:flutter/material.dart';

import '../../styles/textstyles.dart';

class AppOutlineButton extends StatelessWidget {
  final String title;
  final Function onTap;
  final IconData icon;
  const AppOutlineButton({
    Key key,
    @required this.title,
    @required this.onTap,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        padding: EdgeInsets.symmetric(
          vertical: 17,
          horizontal: 14,
        ),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            if(icon != null)
            Icon(
              icon,
              color: Colors.black,
              size: 22,
            ),
            Spacer(),
            Text(
              title ?? '',
              style: AppTextStyles.socialLogin.copyWith(
                color: Colors.white,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
