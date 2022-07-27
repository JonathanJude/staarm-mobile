import 'package:flutter/material.dart';
import 'package:staarm_mobile/core/models/booking_trip_model.dart';
import 'package:staarm_mobile/ui/views/trips/trip_detail/trip_detail_home.dart';
import 'package:staarm_mobile/utils/staarm_page_route.dart';

class TripItem extends StatefulWidget {
  final String carName;
  final String datePeriod;
  final String date;
  final bool isCancelled;
  final TripModel trip;
  final VoidCallback onDelete;

  const TripItem({
    Key key,
    @required this.carName,
    @required this.datePeriod,
    @required this.date,
    @required this.trip,
    this.isCancelled = false,
    this.onDelete,
  }) : super(key: key);

  @override
  State<TripItem> createState() => _TripItemState();
}

class _TripItemState extends State<TripItem> {
  bool isCancelled;

  @override
  initState() {
    super.initState();
    isCancelled = widget.isCancelled;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        bool deleted = await Navigator.push(
              context,
              StaarmPageRoute.routeTo(
                builder: (context) => TripDetail(
                  trip: widget.trip,
                ),
              ),
            ) ??
            false;
        if (deleted) {
          widget.onDelete();
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          children: [
            Divider(
              color: Color(0xFFF1F2F3),
              thickness: 1,
            ),
            SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 80,
                  width: 80,
                  child: Image.network(
                      widget.trip.vehicle.vehiclePhotos.first.url),
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
                          'Your Trip',
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
                          widget.carName ?? '',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color(0xFF231F20),
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          widget.datePeriod ?? '',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            decoration: widget.isCancelled
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            color: Color(0xFF757D8A),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'You ${widget.isCancelled ? 'cancelled' : 'booked'} on ${widget.date}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color(0xFFACB1B8),
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 6),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
