import 'package:flutter/material.dart';
import 'package:staarm_mobile/ui/views/search/get_approved/widgets/get_approved_options_widget.dart';
import 'package:staarm_mobile/utils/staarm_page_route.dart';
import 'package:staarm_mobile/widgets/app_divider.dart';
import 'package:staarm_mobile/widgets/buttons/app_button.dart';
import 'package:staarm_mobile/widgets/buttons/bottom_app_button_container.dart';

import 'upload_profile_picture/profile_picture.dart';

class GetApprovedHome extends StatelessWidget {
  const GetApprovedHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Color(0xFF717171),
        ),
        title: Text(
          'Get approved',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 17,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Text(
                  'Get approved to drive',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Text(
                  'Since this is your first trip, you’ll need to provide us with some information before you can check out.',
                  style: TextStyle(
                    color: Color(0xFF717171),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 20),
              AppDivider(
                thickness: .8,
              ),
              SizedBox(height: 10),
              GetApprovedOptionsWidget(
                title: 'Profile photo',
                subtitle:
                    'Your Staarm host will use this to identify you at the pickup.',
                onTap: () {},
              ),
              GetApprovedOptionsWidget(
                title: 'National Identification Number (NIN)',
                subtitle:
                    'Your Staarm host will use this to identify you at the pickup.',
                onTap: () {},
              ),
              GetApprovedOptionsWidget(
                title: "Driver’s licence",
                subtitle:
                    "You need to have a valid driver’s licence to book a vehicle on Staarm.",
                onTap: () {},
              ),
              GetApprovedOptionsWidget(
                title: 'Payment method',
                subtitle: 'You won’t be charged until you book your trip.',
                onTap: () {},
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
      bottomSheet: BottomAppButtonContainer(
        child: AppButton(
          onPressed: () {
            Navigator.push(
              context,
              StaarmPageRoute.routeTo(
                builder: (context) => UploadKYCProfilePictureView(),
                // builder: (context) => LicenceSuccessView(),
              ),
            );

            // Navigator.push(
            //       context,
            //       StaarmPageRoute.routeTo(
            //         builder: (context) => KYCDriverslicenceView(),
            //       ),
            //     );
          },
          text: 'Continue',
        ),
      ),
    );
  }
}
