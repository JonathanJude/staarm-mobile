import 'package:flutter/material.dart';

import '../styles/textstyles.dart';
import 'app_divider.dart';

class AppContainer extends StatelessWidget {
  final List<Widget> children;
  final Color color;
  final Color topColor;
  final CrossAxisAlignment crossAxisAlignment;
  final EdgeInsets padding;

  const AppContainer({
    Key key,
    @required this.children,
    this.color = Colors.white,
    this.topColor,
    this.padding,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 40),
      decoration: BoxDecoration(
        color: topColor ?? Colors.black,
      ),
      child: Container(
        padding: padding ?? EdgeInsets.symmetric(horizontal: 0, vertical: 16),
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          boxShadow: [
            BoxShadow(
                color: Color(0xFF202046).withOpacity(.08),
                blurRadius: 8,
                spreadRadius: 0,
                offset: Offset(0, -6))
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 5,
              width: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xFFDDDDDD),
              ),
            ),
            SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Text('Log in or sign up',
                    style: AppTextStyles.cardLabel
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: 14.0),
                    child: GestureDetector(
                      onTap: (){},
                      child: Icon(Icons.clear, color: Colors.black, size: 25),
                    ),
                  ),
                ],
              ),
            ),

            AppDivider(
              color: Color(0xFFE7E7E8),
            ),

            SizedBox(height: 7),
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          ],
        ),
      ),
    );
  }
}
