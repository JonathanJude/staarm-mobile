import 'package:flutter/material.dart';
import 'package:staarm_mobile/styles/colors.dart';
import 'package:staarm_mobile/utils/staarm_page_route.dart';
import 'package:staarm_mobile/widgets/buttons/app_button.dart';

import 'complete_listing/complete_listing.dart';

class SafetyAndQualityView extends StatelessWidget {
  final String draftId;
  const SafetyAndQualityView({Key key, @required this.draftId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: AppColors.grey5,
          ),
        ),
        backgroundColor: AppColors.appBackground,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Center(
              child: Image.asset(
                'assets/images/bell_icon.png',
                height: 100,
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 14,
              ),
              child: Text(
                'Safety and quality \nstandards',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 14,
              ),
              child: Text(
                'As a host you’re expected to uphold these standards to maintain a safe and reliable car sharing community:',
                style: TextStyle(
                  color: AppColors.grey5,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            SafetyText(
              text: 'Keep your car well maintained so your guests are safe on the road.',
            ),
            SafetyText(
              text: 'Clean and refuel your car before every trip so your guesst have an enjoyable trip.',
            ),
          ],
        ),
      ),
      bottomSheet: Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.04),
                offset: Offset(1, 0),
                blurRadius: 12,
              )
            ]),
            padding: EdgeInsets.only(
              bottom: 30,
              top: 4,
              left: 30,
              right: 30,
            ),
            child: Row(
              children: [
                Flexible(
                  child: AppButton(
                    color: Color(0xFF824DFF),
                    onPressed: () {
                      Navigator.push(
                        context,
                        StaarmPageRoute.routeTo(
                          builder: (context) => CompleteListingView(
                            draftId: draftId,
                          ),
                        ),
                      );
                    },
                    text: 'Agree & continue',
                  ),
                ),
              ],
            ),
          ),
    );
  }
}


class SafetyText extends StatelessWidget {
  final String text;
  const SafetyText({ Key key, @required this.text }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: Row(
                children: [
                  Text('•',
                    style: TextStyle(
                      color: AppColors.grey5,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: 14),
                  Flexible(
                    child: Text(
                      text ?? '',
                      style: TextStyle(
                        color: AppColors.grey5,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            );
  }
}