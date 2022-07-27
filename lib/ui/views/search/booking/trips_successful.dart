import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/core/providers/user_provider.dart';
import 'package:staarm_mobile/core/services/navigator_service.dart';
import 'package:staarm_mobile/ui/views/search/get_approved/get_approved_home.dart';
import 'package:staarm_mobile/utils/staarm_page_route.dart';
import 'package:staarm_mobile/widgets/buttons/app_button.dart';
import 'package:staarm_mobile/widgets/buttons/bottom_app_button_container.dart';

class TripsSuccessfulView extends StatefulWidget {
  const TripsSuccessfulView({
    Key key,
  }) : super(key: key);

  @override
  _TripsSuccessfulViewState createState() => _TripsSuccessfulViewState();
}

class _TripsSuccessfulViewState extends State<TripsSuccessfulView> {
  final _navService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Color(0xFF717171),
        ),
        title: Text(
          'Booking',
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
            child: TripBookedSuccessWidget()),
      ),
      bottomSheet: Consumer<UserProvider>(
        builder: (context, userProvider, _) => BottomAppButtonContainer(
          child: AppButton(
            onPressed: () {
              if (userProvider.user.approved) {
                _navService.navigatorKey.currentState.pushNamedAndRemoveUntil(
                  '/main',
                  (Route<dynamic> route) => true,
                );
              } else {
                Navigator.push(
                  context,
                  StaarmPageRoute.routeTo(
                    builder: (context) => GetApprovedHome(),
                  ),
                );
              }
            },
            text: userProvider.user.approved
                ? 'Go Home'
                : 'Get Approved to Drive',
          ),
        ),
      ),
    );
  }
}

class CheckOutInfoRow extends StatelessWidget {
  final String title;
  final String value;
  final bool isUnderlined;
  final Color valueColor;
  const CheckOutInfoRow({
    Key key,
    @required this.title,
    @required this.value,
    this.isUnderlined = true,
    this.valueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title ?? '',
            style: TextStyle(
              color: Color(0xFF231F20),
              decoration: isUnderlined ? TextDecoration.underline : null,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            value ?? '',
            style: TextStyle(
              color: valueColor ?? Color(0xFF231F20),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class TripBookedSuccessWidget extends StatelessWidget {
  const TripBookedSuccessWidget({Key key}) : super(key: key);

  Widget _rowItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 6.0),
            child: Text(
              '•  ',
              style: TextStyle(
                color: Color(0xFF231F20),
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Flexible(
            child: Text(
              text ?? '',
              style: TextStyle(
                color: Color(0xFF231F20),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: size.height * .2),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Text(
              'Your  trip has been booked!',
              style: TextStyle(
                color: Color(0xFF231F20),
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Text(
            'You’re ready to hit the road! Don’t forget:',
            style: TextStyle(
              color: Color(0xFF231F20),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 14),
            padding: EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 12,
            ),
            decoration: BoxDecoration(
              color: Color(0xFFF8F8F8),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                _rowItem(
                    'As the primary driver, you must be present with a valid driver’s licence to pick up the car '),
                _rowItem(
                    'Your licence must be valid for the full duration of  the trip'),
                _rowItem('You’ll need the Staarm mobile app to check'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
