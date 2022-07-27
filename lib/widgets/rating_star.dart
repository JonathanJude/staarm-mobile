import 'package:flutter/material.dart';
import 'package:staarm_mobile/styles/colors.dart';

class RatingsStarWidget extends StatelessWidget {
  final int count;
  final Color color;
  final double size;
  const RatingsStarWidget({ Key key, this.count = 1, this.color, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(count, (index) => Icon(Icons.star,
          color: color ?? AppColors.mainPurple,
          size: size ?? 18,
        )).toList(),
    );
  }
}