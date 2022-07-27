import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staarm_mobile/styles/colors.dart';
import 'package:staarm_mobile/widgets/app_divider.dart';

import 'tabs/activity_tab.dart';
import 'tabs/bookings_tab.dart';
import 'tabs/history_tab.dart';

class TripsHomeView extends StatelessWidget {
  const TripsHomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.appBackground,
        appBar: AppBar(
          backgroundColor: AppColors.appBackground,
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'Trips',
            style: TextStyle(
              color: Color(0xFF231F20),
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          bottom: TabBar(
              labelColor: Color(0xFF231F20),
              indicatorColor: AppColors.mainBlack,
              tabs: [
                Tab(
                  text: 'Activity',
                ),
                Tab(
                  text: 'Bookings',
                ),
                Tab(
                  text: 'History',
                ),
              ]),
        ),
        body: TabBarView(
          children: [
            ActivityTab(),
            BookingsTab(),
            HistoryTab(),
          ],
        ),
      ),
    );
  }
}
