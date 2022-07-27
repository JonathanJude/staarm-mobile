import 'package:flutter/material.dart';
import 'package:staarm_mobile/core/models/notifications/notification_model.dart';
import 'package:staarm_mobile/ui/base/base_view.dart';
import 'package:staarm_mobile/ui/views/trips/shared/notification_item.dart';
import 'package:staarm_mobile/ui/views/trips/trip_detail/trip_detail_home.dart';
import 'package:staarm_mobile/ui/views/trips/view_model/activity_view_model.dart';
import 'package:staarm_mobile/utils/staarm_page_route.dart';
import 'package:staarm_mobile/utils/string_utils.dart';
import 'package:staarm_mobile/widgets/app_divider.dart';
import 'package:staarm_mobile/widgets/indicators/staarm_shimmers.dart';

import '../trips_empty_state.dart';

class ActivityTab extends StatelessWidget {
  const ActivityTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //empty state
        // TripsEmptyState(
        //   image: 'assets/images/bell_icon.png',
        //   title: 'You have no activity yet',
        //   subtitle: 'Plan a new trip and drive to any place with a ride of your choice. ',
        // ),

        Expanded(
          child: BaseView<ActivityViewModel>(
            model: ActivityViewModel(),
            onModelReady: (p0) => p0.init(),
            builder: (context, model, _) {
              if (model.isLoading || model.notificationModel == null) {
                return StaarmShimmers.loadCars();
              }

              NotificationModel notificationModel = model.notificationModel;

              if (notificationModel.isEmpty) {
                return TripsEmptyState(
                  image: 'assets/images/book_icon.png',
                  title: 'You have no notifications yet',
                  subtitle: '',
                );
              }

              List<OtherNotification> otherNotifications =
                  notificationModel.otherNotifications;

              List<TripRequestNotification> tripRequestNotifications =
                  notificationModel.tripRequests;

              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 13.0),
                    child: Text(
                      'Trip Requests',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF231F20),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Column(
                    children: List.generate(
                      tripRequestNotifications.length,
                      (index) {
                        TripRequestNotification notification =
                            tripRequestNotifications[index];
                        return GestureDetector(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              StaarmPageRoute.routeTo(
                                builder: (context) => TripDetail(
                                  trip: notification.data.toTripModel(),
                                ),
                              ),
                            );
                            model.silentReload();
                          },
                          child: NotificationItem(
                            date: formatDateTime(notification.date),
                            title: notification.data.title,
                            message: notification.data.message,
                          ),
                        );
                      },
                    ),
                  ),
                  AppDivider(
                    thickness: 1.2,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 13.0),
                    child: Text(
                      'Other notifications',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF231F20),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Column(
                    children: List.generate(
                      otherNotifications.length,
                      (index) {
                        OtherNotification notification =
                            otherNotifications[index];
                        return NotificationItem(
                          date: formatDateTime(notification.date),
                          title: notification.data.title,
                          message: notification.data.message,
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
