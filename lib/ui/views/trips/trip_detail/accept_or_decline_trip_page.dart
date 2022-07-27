import 'package:flutter/material.dart';
import 'package:staarm_mobile/core/models/booking_trip_model.dart';
import 'package:staarm_mobile/styles/colors.dart';
import 'package:staarm_mobile/ui/base/base_view.dart';
import 'package:staarm_mobile/ui/views/trips/view_model/trip_view_model.dart';
import 'package:staarm_mobile/utils/string_utils.dart';
import 'package:staarm_mobile/widgets/app_divider.dart';
import 'package:staarm_mobile/widgets/buttons/app_button.dart';

class AcceptOrDeclineTripPage extends StatelessWidget {
  final TripModel trip;
  const AcceptOrDeclineTripPage({
    Key key,
    this.trip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBackground,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: 30,
            color: Color(0xFF757D8A),
          ),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        centerTitle: true,
        title: Text(
          "Trip request",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 15, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: BaseView<TripViewModel>(
          model: TripViewModel(),
          onModelReady: (model) => model.init(trip),
          builder: (context, model, _) {
            var inDays2 = DateTime.now().difference(trip.startDate).inDays;
            inDays2 = inDays2 < 0 ? 0 : inDays2;

            var inDays3 = trip.endDate.difference(trip.startDate).inDays;
            inDays3 = inDays3 < 0 ? 0 : inDays3;

            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    trip.vehicle.details.fullName,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "$inDays3 days   N${trip.vehicle.price}",
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: 15),
                  AppDivider(
                    color: Color(0xFFDADADA),
                    thickness: .7,
                  ),
                  SizedBox(height: 15),
                  Text(
                      "You got a reservation for ${formatDateTime(trip.startDate, false)} - ${formatDateTime(trip.endDate, false)}."
                      "\nAccept if you're available to host or delcine if it doesn't work for you."),
                  Spacer(),
                  AppButton(
                    isLoading: model.isLoading,
                    isExpanded: true,
                    text: "Continue",
                    onPressed: model.isLoadingForDecline
                        ? null
                        : () {
                            model.acceptTrip(context);
                          },
                  ),
                  AppButton(
                    isLoading: model.isLoadingForDecline,
                    isExpanded: true,
                    text: "Decline",
                    onPressed: model.isLoading
                        ? null
                        : () {
                            model.declineTrip(context);
                          },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
