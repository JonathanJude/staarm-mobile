import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:staarm_mobile/styles/colors.dart';

class CarFeatureItem extends StatelessWidget {
  final String text;
  final bool selected;
  final Function onTap;
  const CarFeatureItem({
    Key key,
    @required this.text,
    this.selected = false, this.onTap,
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected ? AppColors.mainPurple : Color(0xFFE1E3E6),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/images/car_features/${text.toLowerCase().replaceAll("-", "_").replaceAll(" ", "_")}.svg"),
            // Container(
            //   height: 40,
            //   width: 40,
            //   decoration: BoxDecoration(
            //     color: Color(0xFFC4C4C4),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
              ),
              child: Text(
                text ?? '',
                style: TextStyle(
                  color: selected ? AppColors.mainPurple : Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
