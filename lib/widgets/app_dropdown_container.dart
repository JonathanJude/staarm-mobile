import 'package:flutter/material.dart';

class AppDropdownButton extends StatelessWidget {
  final String hint;
  final String value;
  final Function onTap;
  const AppDropdownButton({
    Key key,
    @required this.hint,
    this.value,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 10,
        ),
        margin: EdgeInsets.symmetric(
          vertical: 6,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xFFACB1B8),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (value != null && value.isNotEmpty)
                  Text(
                    hint ?? '',
                    style: TextStyle(
                      color: Color(0xFF717171),
                      fontSize: 10,
                    ),
                  ),
                Text(
                  value ?? hint,
                  style: TextStyle(
                    color:
                        value == null ? Color(0xFF717171) : Color(0xFF231F20),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Spacer(),
            Icon(
              Icons.arrow_drop_down_outlined,
              color: Color(0xFF717171),
            )
          ],
        ),
      ),
    );
  }
}
