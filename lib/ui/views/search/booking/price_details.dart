import 'package:flutter/material.dart';
import 'package:staarm_mobile/utils/app_helper.dart';
import 'package:staarm_mobile/utils/staarm_formatter.dart';
import 'package:staarm_mobile/widgets/app_divider.dart';

class PriceDetailsView extends StatelessWidget {
  final num price;
  final DateTime tripStartDate;
  final DateTime tripEndDate;

  const PriceDetailsView({
    Key key,
    @required this.price,
    @required this.tripStartDate,
    @required this.tripEndDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Color(0xFF717171),
        ),
        title: Text(
          'Price details',
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
              Text(
                'Included',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${AppHelper.getDaysBetweenDates(tripStartDate, tripEndDate)} - day trip',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF717171),
                      ),
                    ),
                    Spacer(),
                    Text(
                      StaarmFormatter.formatCurrencyInput(AppHelper.getTripAmountByPeriod(price, tripStartDate, tripEndDate).toString()) ?? '',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              AppDivider(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${AppHelper.getDaysBetweenDates(tripStartDate, tripEndDate)} + day trip',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Text(
                      StaarmFormatter.formatCurrencyInput(AppHelper.getTripAmountByPeriod(price, tripStartDate, tripEndDate).toString()) ?? '',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              AppDivider(height: 18),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Not yet included (Applied at checkout)',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Protection plan',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF717171),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Includes liability insurance and physical damage protection plans: you’ll  select a plan when you’re checking out.",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF717171),
                    ),
                  ),
                ],
              ),
              AppDivider(height: 18),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Trip fee',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF717171),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "This helps us run the Staarm platform",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF717171),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
