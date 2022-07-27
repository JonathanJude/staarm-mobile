import 'package:flutter/material.dart';
import 'package:staarm_mobile/core/models/booking_trip_model.dart';
import 'package:staarm_mobile/ui/base/base_view.dart';
import 'package:staarm_mobile/ui/views/trips/shared/trip_item.dart';
import 'package:staarm_mobile/ui/views/trips/trips_empty_state.dart';
import 'package:staarm_mobile/ui/views/trips/view_model/booking_view_model.dart';
import 'package:staarm_mobile/utils/string_utils.dart';
import 'package:staarm_mobile/widgets/indicators/staarm_shimmers.dart';


class HostsEarningsTab extends StatefulWidget {
  const HostsEarningsTab({Key key}) : super(key: key);

  @override
  _HostsEarningsTabState createState() => _HostsEarningsTabState();
}

class _HostsEarningsTabState extends State<HostsEarningsTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BaseView<BookingViewModel>(
      model: BookingViewModel(),
      onModelReady: (model) => model.getBookings(),
      builder: (context, model, _) {
        if (model.isLoading || model.bookings == null) {
          return StaarmShimmers.loadCars();
        }

        List<TripModel> trips = model.bookings;

        if (trips.isEmpty) {
          return TripsEmptyState(
            image: 'assets/images/book_icon.png',
            title: 'You have no bookings yet',
            subtitle:
                'Plan a new trip and drive to any place with a ride of your choice. ',
          );
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 13.0),
              child: Text(
                'August 2021',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF231F20),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    trips.length,
                    (index) {
                      TripModel b = trips[index];
                      return TripItem(
                        carName: b.vehicle.details.fullName,
                        datePeriod:
                            "${formatDateTime(b.startDate, false)} - ${formatDateTime(b.endDate, false)}",
                        date: formatDateTime(b.date),
                        trip: b,
                        onDelete: (){
                          model.deleteAt(index);
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
