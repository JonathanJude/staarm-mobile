import 'package:flutter/material.dart';

import '../../../../styles/textstyles.dart';

class SearchPageInfo extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  const SearchPageInfo({
    Key key,
    @required this.image,
    @required this.title,
    @required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            image,
            height: 24,
            width: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              title ?? '',
              style: AppTextStyles.cta,
            ),
          ),
          Text(
            subtitle ?? '',
            style: AppTextStyles.input,
          ),
        ],
      ),
    );
  }
}