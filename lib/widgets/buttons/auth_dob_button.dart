import 'package:flutter/material.dart';

import '../../styles/colors.dart';
import '../../styles/textstyles.dart';

class AuthDOBButton extends StatelessWidget {
  final String title;
  final String text;
  final Function onTap;
  const AuthDOBButton({Key key, this.text, this.title = 'DOB (DD/MM/YYYY)', this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 12),
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 12,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xFFB2B2B2),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Color(0xFF717171),
                      // height: 0,
                      fontSize: 10,
                    ),
                  ),
                ),
                Text(
                  text ?? '(DD/MM/YYYY)',
                  style: AppTextStyles.input.copyWith(fontSize: 16),
                ),
              ],
            ),
            Icon(
              Icons.arrow_drop_down,
              color: AppColors.grey5,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
