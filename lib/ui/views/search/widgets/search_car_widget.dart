import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:staarm_mobile/core/models/vehicle/vehicle_model.dart';
import 'package:staarm_mobile/core/providers/vehicle_provider.dart';
import 'package:staarm_mobile/ui/views/search/modals/select_trip_date_modal/select_trip_date_modal.dart';
import 'package:staarm_mobile/utils/staarm_formatter.dart';

import '../../../../styles/textstyles.dart';
import '../booking/booking_view/booking_view.dart';

class SearchCarWidget extends StatelessWidget {
  final String image;
  final double widthFactor;
  final VehicleModel vehicle;
  final DateTime pickupDate;
  final DateTime returnDate;
  final DateTime pickupTime;
  final DateTime returnTime;
  final bool selectDate;
  SearchCarWidget({
    Key key,
    this.image,
    this.widthFactor,
    @required this.vehicle,
    this.pickupDate,
    this.returnDate,
    this.pickupTime,
    this.returnTime,
    this.selectDate = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () async {
        if (selectDate) {
          await showCupertinoModalBottomSheet(
            expand: true,
            context: context,
            isDismissible: false,
            useRootNavigator: true,
            enableDrag: false,
            backgroundColor: Colors.transparent,
            builder: (context) => SelectTripDateModalView(
              address: null,
              onSelect: (sPickupDate, sPickupTime, sReturnDate, sReturnTime) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => BookingView(
                      vehicle: vehicle,
                      pickupDate:
                          sPickupDate ?? DateTime.now().add(Duration(days: 1)),
                      returnDate:
                          sReturnDate ?? DateTime.now().add(Duration(days: 5)),
                      pickupTime: sPickupTime ?? DateTime.now(),
                      returnTime: sReturnTime ?? DateTime.now(),
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BookingView(
                vehicle: vehicle,
                pickupDate: pickupDate ?? DateTime.now().add(Duration(days: 1)),
                returnDate: returnDate ?? DateTime.now().add(Duration(days: 5)),
                pickupTime: pickupTime ?? DateTime.now(),
                returnTime: returnTime ?? DateTime.now(),
              ),
            ),
          );
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: widthFactor == null ? size.width : (size.width * widthFactor),
          margin: widthFactor == null
              ? EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 10,
                )
              : EdgeInsets.only(right: 13),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Color(0xFFE7E7E8),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: widthFactor == null
                    ? size.width
                    : (size.width * widthFactor),
                height: 200,
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      vehicle.vehiclePhotos.first.url,
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(topRight: Radius.circular(8)),
                ),
                child: Stack(
                  children: [
                    // VehicleFavoriteIcon(
                    //   vehicle: vehicle,
                    // ),

                    //TODO: add favorite back
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '${StaarmFormatter.formatCurrencyInput(vehicle.price.toString())}/day',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 14.0,
                  horizontal: 14,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: 8),
                    Text(
                      "${vehicle.details.make} ${vehicle.details.model} ${vehicle.details.year}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Text(
                          //   "${vehicle.avgRating.toString()}",
                          //   style: AppTextStyles.input,
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          //   child: Icon(
                          //     Icons.star,
                          //     color: AppColors.mainPurple,
                          //     size: 20,
                          //   ),
                          // ),
                          if (vehicle?.totalTrips != null &&
                              vehicle.totalTrips > 0)
                            Text('(${vehicle.totalTrips.toString()} trips)',
                                style: AppTextStyles.input),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class VehicleFavoriteIcon extends StatelessWidget {
  final VehicleModel vehicle;
  const VehicleFavoriteIcon({Key key, @required this.vehicle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<VehicleProvider>(
      builder: (context, vehicleProv, _) => GestureDetector(
        onTap: () {
          vehicleProv.toggleFavorite(vehicle);
        },
        child: Align(
          alignment: Alignment.topRight,
          child: Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: vehicleProv.isFavorited(vehicle)
                  ? Colors.red
                  : Color(0xFF231F20).withOpacity(.24),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.favorite_outline,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
