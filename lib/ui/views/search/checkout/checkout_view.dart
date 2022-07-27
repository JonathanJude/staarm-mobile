import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/core/models/protection_plan.dart';
import 'package:staarm_mobile/core/models/vehicle/vehicle_model.dart';
import 'package:staarm_mobile/core/services/navigator_service.dart';
import 'package:staarm_mobile/styles/colors.dart';
import 'package:staarm_mobile/ui/base/base_view.dart';
import 'package:staarm_mobile/utils/app_helper.dart';
import 'package:staarm_mobile/utils/staarm_formatter.dart';
import 'package:staarm_mobile/widgets/app_divider.dart';
import 'package:staarm_mobile/widgets/buttons/app_button.dart';
import 'package:staarm_mobile/widgets/buttons/bottom_app_button_container.dart';
import 'package:staarm_mobile/widgets/rating_star.dart';

import 'view_model.dart';


class CheckoutView extends StatefulWidget {
  final VehicleModel vehicle;
  final DateTime tripStartDate;
  final DateTime tripEndDate;
  final ProtectionPlanModel protectionPlan;
  const CheckoutView({
    Key key,
    @required this.vehicle,
    @required this.tripStartDate,
    @required this.tripEndDate,
    @required this.protectionPlan,
  }) : super(key: key);

  @override
  _CheckoutViewState createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  final _navService = locator<NavigationService>();
  bool _tripBooked = false;

  _bookTrip() {
    setState(() {
      _tripBooked = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<CheckoutViewModel>(
      model: CheckoutViewModel(),
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Color(0xFF717171),
          ),
          title: Text(
            'Checkout',
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
            child: _tripBooked
                ? TripBookedSuccessWidget()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${widget.vehicle?.vehicleOwner?.firstName}'s",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Text(
                                        "${widget.vehicle.details.make} ${widget.vehicle.details.model} ${widget.vehicle.details.year}",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            '4.6',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          RatingsStarWidget(
                                            count: 1,
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            '(165 trips)',
                                            style: TextStyle(
                                              color: Color(0xFF717171),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          CircleAvatar(
                            backgroundImage: AssetImage(
                                'assets/images/mock_images/man_image.png'),
                            maxRadius: 35,
                            minRadius: 25,
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: Icon(
                              Icons.calendar_today,
                              color: Color(0xFF757D8A),
                              size: 16,
                            ),
                          ),
                          Text(
                            "${StaarmFormatter.formatTripDate(widget.tripStartDate)} - ${StaarmFormatter.formatTripDate(widget.tripEndDate)}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 14),
                      AppDivider(
                        height: 13,
                        thickness: .7,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 9.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.place_outlined,
                              color: AppColors.grey5,
                              size: 20,
                            ),
                            SizedBox(width: 15),
                            Flexible(
                              child: Text(
                                "${widget.vehicle.pickUp}",
                                style: TextStyle(
                                  color: Color(0xFF231F20),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      AppDivider(
                        height: 13,
                        thickness: .7,
                      ),
                      SizedBox(height: 14),
                      CheckOutInfoRow(
                        title: '${StaarmFormatter.formatCurrencyInput(widget.vehicle.price.toString())} X ${AppHelper.getDaysBetweenDates(widget.tripStartDate, widget.tripEndDate)} day(s)',
                        value: StaarmFormatter.formatCurrencyInput(AppHelper.getTripAmountByPeriod(widget.vehicle.price, widget.tripStartDate, widget.tripEndDate).toString()) ?? '',
                        isUnderlined: false,
                      ),
                      // CheckOutInfoRow(
                      //   title: 'Trip fee',
                      //   value: 'N11,925',
                      // ),
                      CheckOutInfoRow(
                        title: widget.protectionPlan?.name ?? '',
                        value: StaarmFormatter.formatCurrencyInput(model.totalInsuranceAmount(widget.protectionPlan.price, widget.tripStartDate, widget.tripEndDate) .toString()),
                      ),
                      // CheckOutInfoRow(
                      //   title: '3+ day discount',
                      //   value: '-N5,500',
                      //   valueColor: Color(0xFF239373),
                      // ),
                      SizedBox(height: 12),
                      AppDivider(
                        height: 20,
                        thickness: .7,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(
                                color: Color(0xFF231F20),
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              StaarmFormatter.formatCurrencyInput(model.tripTotal(widget.vehicle.price, widget.tripStartDate, widget.tripEndDate, widget.protectionPlan).toString()),
                              style: TextStyle(
                                color: Color(0xFF231F20),
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      AppDivider(
                        height: 20,
                        thickness: .7,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 14.0),
                              child: Icon(
                                Icons.check_box_outlined,
                                color: Color(0xFF757D8A),
                                size: 23,
                              ),
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Free Cancellation',
                                    style: TextStyle(
                                      color: Color(0xFF717171),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      'You get a full refund  if you cancel before 6 hours before the trip starts.',
                                      style: TextStyle(
                                        color: Color(0xFF717171),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      AppDivider(
                        height: 20,
                        thickness: .7,
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   StaarmPageRoute.routeTo(
                          //     builder: (context) => ProtectionPlansView(),
                          //   ),
                          // );

                          Navigator.of(context).pop();
                        },
                        child: Container(
                          decoration: BoxDecoration(),
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'Booking steps',
                                    style: TextStyle(
                                      color: Color(0xFF231F20),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 7.0),
                                    child: Text(
                                      'Protection plans',
                                      style: TextStyle(
                                        color: Color(0xFF717171),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Flexible(
                                child: Text(
                                  widget.protectionPlan?.name,
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Color(0xFF824DFF),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      AppDivider(
                        height: 20,
                        thickness: .7,
                      ),
                      GestureDetector(
                        onTap: model.selectedCard != null ? () {
                          model.selectPaymentMethod();
                        } : null,
                        child: Container(
                          decoration: BoxDecoration(),
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 7.0),
                                child: Text(
                                  'Payment info',
                                  style: TextStyle(
                                    color: Color(0xFF717171),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),

                              if(model.selectedCard != null)
                              Text(
                                '${model.selectedCard.cardType.toUpperCase()} ${model.selectedCard.last4}',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Color(0xFF824DFF),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      AppDivider(
                        height: 20,
                        thickness: .7,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          'You’ll be able to message ${widget.vehicle.vehicleOwner.firstName} after checkout',
                          style: TextStyle(
                            color: Color(0xFF717171),
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                    ],
                  ),
          ),
        ),
        bottomSheet: BottomAppButtonContainer(
          child: AppButton(
            isLoading: model.isLoading,
            onPressed: () {

               final DateFormat dateRequestFormatter = DateFormat('yyyy-MM-dd');

              String startDate = dateRequestFormatter.format(widget.tripStartDate);
              String endDate = dateRequestFormatter.format(widget.tripEndDate);

               print("${widget.vehicle}, $startDate $endDate ${widget.protectionPlan}");

              if(model.selectedCard == null) {
                model.selectPaymentMethod();
              }else{
                model.bookTrip(widget.vehicle, widget.tripStartDate, widget.tripEndDate, widget.protectionPlan);
              }

              // if (_tripBooked) {
              //   _navService.navigatorKey.currentState.pushNamedAndRemoveUntil(
              //     '/main',
              //     (Route<dynamic> route) => true,
              //   );
              // } else {
              //   _bookTrip();
              // }


            },
            text: model.selectedCard == null ? 'Select Payment method' : 'Book this ride',
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
