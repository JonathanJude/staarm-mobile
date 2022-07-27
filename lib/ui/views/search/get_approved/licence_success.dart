import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staarm_mobile/core/providers/user_provider.dart';
import 'package:staarm_mobile/styles/colors.dart';
import 'package:staarm_mobile/ui/views/search/booking/booking_view/booking_view.dart';
import 'package:staarm_mobile/ui/views/trips/home.dart';
import 'package:staarm_mobile/utils/staarm_page_route.dart';
import 'package:staarm_mobile/widgets/buttons/app_button.dart';
import 'package:staarm_mobile/widgets/buttons/bottom_app_button_container.dart';

class LicenceSuccessView extends StatelessWidget {
  const LicenceSuccessView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Color(0xFF717171),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 17,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * .05),
            Center(
              child: Image.asset(
                'assets/images/book_icon.png',
                height: size.height * .12,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Text(
                'You’re  all done and ready to drive',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color(0xFF231F20),
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Text(
                'You’re ready to hit the road! Don’t forget:',
                style: TextStyle(
                  color: Color(0xFF231F20),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 14,
              ),
              padding: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 12,
              ),
              decoration: BoxDecoration(
                color: AppColors.grey2,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  _textWidget(
                      'As the primary driver, you must be present with a valid driver’s licence to pick up the car '),
                  _textWidget(
                      'Your licence must be valid for the full duration of  the trip'),
                  _textWidget(
                      'You’ll need the Staarm mobile app to check-in and checkout.'),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomSheet: BottomAppButtonContainer(
        child: AppButton(
          onPressed: () {
            UserProvider _userProvider =
                Provider.of<UserProvider>(context, listen: false);

            if (_userProvider.tempPropertiesAvailable &&
                _userProvider.verifyingFromBookingScreen) {
              Navigator.pushAndRemoveUntil(
                context,
                StaarmPageRoute.routeTo(
                  builder: (context) => BookingView(
                    vehicle: _userProvider.tempVehicle,
                    pickupDate: _userProvider.tempTripStartDate,
                    pickupTime: _userProvider.tempTripStartTime,
                    returnDate: _userProvider.tempTripEndDate,
                    returnTime: _userProvider.tempTripEndTime,
                  ),
                ),
                (route) => false,
              );
            } else {
              Navigator.pushReplacement(
                context,
                StaarmPageRoute.routeTo(
                  builder: (context) => TripsHomeView(),
                ),
              );
            }
          },
          text: 'Message your host',
        ),
      ),
    );
  }

  Widget _textWidget(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              right: 10,
            ),
            child: Text(
              '•',
              style: TextStyle(
                color: Color(0xFF060606),
                fontSize: 16,
              ),
            ),
          ),
          Flexible(
            child: Text(
              text ?? '',
              style: TextStyle(
                color: Color(0xFF060606),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
