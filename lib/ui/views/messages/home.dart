import 'package:flutter/material.dart';
import 'package:staarm_mobile/styles/colors.dart';
import 'package:staarm_mobile/ui/views/trips/trips_empty_state.dart';
import 'package:staarm_mobile/widgets/app_divider.dart';

class MessagesHomeView extends StatelessWidget {
  const MessagesHomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(
        backgroundColor: AppColors.appBackground,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Column(
          children: [
            Text(
              'Messages',
              style: TextStyle(
                color: Color(0xFF231F20),
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            // SizedBox(height: 10),
            // Divider(
            //   color: Color(0xFFF1F2F3),
            //   thickness: 1,
            // ),
            // SizedBox(height: 6),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppDivider(
                color: Color(0xFFDADADA),
              ),
              TripsEmptyState(
                image: 'assets/images/message_icon.png',
                title: 'You have no messages yet',
                subtitle:
                    'Plan a new trip and drive to any place with a ride of your choice. ',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
