import 'package:flutter/material.dart';
import 'package:staarm_mobile/styles/textstyles.dart';

class TripsEmptyState extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  const TripsEmptyState({
    Key key,
    @required this.image,
    @required this.title,
    @required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          SizedBox(height: 30),
          Image.asset(
            image,
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(title ?? '',
                textAlign: TextAlign.center,
                style: AppTextStyles.cta.copyWith(
                  color: Color(0xFF231F20),
                  fontWeight: FontWeight.w500,
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(subtitle ?? '',
                textAlign: TextAlign.center,
                style: AppTextStyles.input.copyWith(
                  color: Color(0xFF717171),
                )),
          ),
        ],
      ),
    );
  }
}
