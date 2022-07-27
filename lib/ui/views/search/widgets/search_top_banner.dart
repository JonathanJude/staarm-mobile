import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';
import '../../../../values/images.dart';


class SearchTopBanner extends StatelessWidget {
  const SearchTopBanner({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      child: Stack(
        fit: StackFit.loose,
        children: [
          Image.asset(
            AppImages.searchTopBanner,
            fit: BoxFit.cover,
            width: double.infinity,
            // height: size.height * .4,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: kTopPaddingHeight),
                SizedBox(height: size.height * .1),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Move around\nwith ease',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
