import 'package:flutter/material.dart';
import 'package:staarm_mobile/core/models/booking_trip_model.dart';
import 'package:staarm_mobile/styles/colors.dart';

import 'tabs/message_tab.dart';
import 'tabs/trip_detail_tab.dart';

class TripDetail extends StatelessWidget {
  final TripModel trip;
  final bool isCancelled;
  const TripDetail({Key key, this.trip, this.isCancelled}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.appBackground,
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
          centerTitle: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                width: 80,
                child: Image.network(trip.vehicle.vehiclePhotos.first.url),
                decoration: BoxDecoration(
                  color: Color(0xFFF4F5F6),
                ),
              ),
              SizedBox(width: 13),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Text(
                        'Booked trip',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color(0xFF757D8A),
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Text(
                        "${trip.vehicle.vehicleOwner.firstName}'s ${trip.vehicle.details.make}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color(0xFF231F20),
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(height: 6),
                  ],
                ),
              ),
            ],
          ),
          bottom: TabBar(
              labelColor: Color(0xFF231F20),
              indicatorColor: AppColors.mainBlack,
              tabs: [
                Tab(
                  text: 'Details',
                ),
                Tab(
                  text: 'Messages',
                )
              ]),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              TripDetailTab(
                trip: trip,
                onDeleted: () {
                  Navigator.pop(context, true);
                },
              ),
              MessageTab(
                trip: trip,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
