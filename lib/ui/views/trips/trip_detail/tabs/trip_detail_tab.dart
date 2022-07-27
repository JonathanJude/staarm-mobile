import 'package:flutter/material.dart';
import 'package:staarm_mobile/core/models/booking_trip_model.dart';
import 'package:staarm_mobile/ui/base/base_view.dart';
import 'package:staarm_mobile/ui/views/trips/view_model/trip_view_model.dart';
import 'package:staarm_mobile/utils/string_utils.dart';
import 'package:staarm_mobile/widgets/app_divider.dart';

class TripDetailTab extends StatelessWidget {
  final TripModel trip;
  final VoidCallback onDeleted;
  const TripDetailTab({Key key, this.trip, this.onDeleted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<TripViewModel>(
        model: TripViewModel(),
        onModelReady: (model) => model.init(trip),
        builder: (context, model, _) {
          var inDays2 = DateTime.now().difference(trip.startDate).inDays;
          inDays2 = inDays2 < 0 ? 0 : inDays2;
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 12,
                  ),
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Color(0xFFE1E3E6))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.shield,
                        color: Color(0xFF757D8A),
                        size: 28,
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "You’re currently on the Basic protectiopn plan for your with ${trip.vehicle.vehicleOwner.firstName}'s ${trip.vehicle.details.make}. Reduce potentiel expensesby upgrading to premium for N${trip.protectionPlan.price}/day.",
                              style: TextStyle(
                                color: Color(0xFF717171),
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 16),
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 17,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFF824DFF).withOpacity(.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Upgrade now',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF824DFF),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Your trips starts in ${inDays2} days',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color(0xFF231F20),
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                AppDivider(
                  color: Color(0xFFDADADA),
                  thickness: .7,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TripCheckInOutColumn(
                        title: 'Check-in',
                        date: '${formatDateTime(trip.startDate)}',
                        time: '',
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 30,
                        ),
                        width: 1.3,
                        height: 60,
                        decoration: BoxDecoration(color: Color(0xFFE1E3E6)),
                      ),
                      TripCheckInOutColumn(
                        title: 'Check-out',
                        date: '${formatDateTime(trip.endDate)}',
                        time: '',
                      ),
                    ],
                  ),
                ),
                AppDivider(
                  color: Color(0xFFDADADA),
                  thickness: .7,
                ),
                GestureDetector(
                  onTap: () async {
                    bool cancelled = await model.cancelTrip();
                    if (cancelled) {
                      onDeleted();
                    }
                  },
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Cancel trip",
                            style: TextStyle(
                              color: Color(0xFF231F20),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.clear,
                          color: Color(0xff757D8A),
                        )
                      ],
                    ),
                  ),
                ),
                AppDivider(
                  color: Color(0xFFDADADA),
                  thickness: .7,
                ),
                Text(
                  'About the car',
                  style: TextStyle(
                    color: Color(0xFF231F20),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  " ${trip.vehicle.vehicleOwner.firstName}'s ${trip.vehicle.details.make}",
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "licence plate",
                      ),
                    ),
                    Text(
                      " ${trip.vehicle.licenceNumber}",
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Protection",
                      ),
                    ),
                    Text(
                      " ${trip.protectionPlan.name}",
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}

class TripCheckInOutColumn extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  const TripCheckInOutColumn({
    Key key,
    @required this.title,
    @required this.date,
    @required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? '',
          style: TextStyle(
            color: Color(0xFF231F20),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Text(
            date ?? '',
            style: TextStyle(
              color: Color(0xFF717171),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Text(
          time ?? '',
          style: TextStyle(
            color: Color(0xFF717171),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
