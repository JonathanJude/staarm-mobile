import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  final String title;
  final String message;
  final String date;
  const NotificationItem({
    Key key,
    @required this.title,
    @required this.message,
    @required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        children: [
          Divider(
            color: Color(0xFFF1F2F3),
            thickness: 1,
          ),
          SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: Color(0xFFF4F5F6),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 13),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                        title ?? '',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color(0xFF231F20),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Text(
                      message ?? '',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color(0xFF717171),
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      date ?? '',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color(0xFFACB1B8),
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 6),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
