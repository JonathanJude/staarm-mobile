import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../styles/textstyles.dart';
import '../../../../values/images.dart';

class BecomeAHostWidget extends StatelessWidget {
  const BecomeAHostWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            height: size.height * .25,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFF222222),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 14.0,
                    horizontal: 40,
                  ),
                  child: Text(
                    'Become a Host',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Text(
                  'Earn extra income and unlock new opportunities by sharing your car.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () async {
                    String _url = 'https://staarm.com/host.html';

                    if (await canLaunch(_url)) {
                      launch(_url);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Learn more',
                      style: AppTextStyles.cta,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: size.height * .22,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                image: DecorationImage(
                  image: AssetImage(AppImages.becomeAHost),
                  fit: BoxFit.cover,
                )),
          )
        ],
      ),
    );
  }
}
