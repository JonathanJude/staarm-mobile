import 'package:flutter/material.dart';

import '../styles/colors.dart';

class OrWidget extends StatelessWidget {
  const OrWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Divider(
          color: Color(0xFFB0B0B0),
        )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            'or',
            style: TextStyle(
              color: AppColors.mainGrey,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(
            child: Divider(
          color: Color(0xFFB0B0B0),
        )),
      ],
    );
  }
}
