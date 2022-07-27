import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staarm_mobile/core/models/vehicle/vehicle_model.dart';
import 'package:staarm_mobile/core/providers/user_provider.dart';
import 'package:staarm_mobile/ui/base/base_view.dart';
import 'package:staarm_mobile/ui/views/auth/login_or_signup/login_or_signup_view.dart';
import 'package:staarm_mobile/ui/views/search/booking/select_protection_plan/select_protection_plan.dart';
import 'package:staarm_mobile/ui/views/search/car_owner_profile/car_owner_profile.dart';
import 'package:staarm_mobile/utils/app_helper.dart';
import 'package:staarm_mobile/utils/staarm_formatter.dart';
import 'package:staarm_mobile/utils/staarm_modal_helpers.dart';
import 'package:staarm_mobile/utils/staarm_page_route.dart';
import 'package:staarm_mobile/widgets/buttons/app_button.dart';
import 'package:staarm_mobile/widgets/rating_star.dart';

import '../../../../../styles/colors.dart';
import '../../../../../styles/textstyles.dart';
import '../../../../../utils/constants.dart';
import '../../../../../widgets/app_divider.dart';
import '../../widgets/booking_appbar_icon_button.dart';
import '../../widgets/booking_view_carousel.dart';
import '../price_details.dart';
import 'view_model.dart';

class BookingView extends StatelessWidget {
  final VehicleModel vehicle;
  final DateTime pickupDate;
  final DateTime returnDate;
  final DateTime pickupTime;
  final DateTime returnTime;
  const BookingView({
    Key key,
    @required this.vehicle,
    this.pickupDate,
    this.returnDate,
    this.pickupTime,
    this.returnTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BaseView<BookingViewModel>(
      model: BookingViewModel(),
      onModelReady: (model) => model.init(
        pickupDate,
        pickupTime,
        returnDate,
        returnTime,
      ),
      builder: (context, model, _) => Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              // titleSpacing: 10,
              toolbarHeight: kToolbarHeight + 15,
              centerTitle: true,
              pinned: true,
              elevation: 0,
              expandedHeight: kBookingTopBarHeight,

              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    Hero(
                      tag: 'car_images',
                      child: BookingViewCarousel(
                        images:
                            vehicle.vehiclePhotos.map((e) => e.url).toList(),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: Container(
                        padding: EdgeInsets.all(0.2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Card(
                          shape: CircleBorder(),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(360),
                            child: Container(
                              width: 74,
                              height: 74,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: vehicle.vehicleOwner.profilePic == null
                                  ? Icon(Icons.person_rounded)
                                  : Image.network(
                                      vehicle.vehicleOwner.profilePic,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              title: Row(
                children: [
                  BookingAppBarIconButton(
                    icon: Icons.arrow_back_ios_new_outlined,
                    onTap: () {
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      } else {
                        Navigator.of(context).popAndPushNamed('/main');
                      }
                    },
                  ),
                  Spacer(),
                  BookingAppBarIconButton(
                    icon: Icons.share_outlined,
                  ),
                  // BookingAppBarIconButton(
                  //   icon: Icons.favorite_outline,
                  // ),
                  //TODO: add favorites back
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 15,
                ),
                child: Consumer<UserProvider>(
                  builder: (context, userProvider, _) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${vehicle.vehicleOwner.firstName}'s",
                        style: AppTextStyles.input,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: Text(
                          "${vehicle.details.make} ${vehicle.details.model} ${vehicle.details.year}",
                          style: TextStyle(
                            color: Color(0xFF231F20),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // Text(
                            //   '4.6',
                            //   style: AppTextStyles.input,
                            // ),
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.symmetric(horizontal: 6.0),
                            //   child: Icon(
                            //     Icons.star,
                            //     color: AppColors.mainPurple,
                            //     size: 20,
                            //   ),
                            // ),

                            if (vehicle?.totalTrips != null &&
                                vehicle.totalTrips > 0)
                              Text(
                                '(${vehicle.totalTrips.toString()} trip(s))',
                                style: AppTextStyles.input
                                    .copyWith(color: Color(0xFF717171)),
                              ),
                          ],
                        ),
                      ),
                      // SizedBox(height: 23),
                      AppDivider(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Trip date & time',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      GestureDetector(
                        onTap: (){
                          model.updateTripDates();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 17.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: AppColors.grey5,
                                size: 18,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Text(
                                    "${StaarmFormatter.formatTripDate(model.tripStartDate)} - ${StaarmFormatter.formatTripDate(model.tripEndDate)}",
                                    style: TextStyle(
                                      color: Color(0xFF717171),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),

                              // Spacer(),

                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Text(
                                  'Edit',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      AppDivider(
                        height: 30,
                      ),

                      Text(
                        'Pickup & return location',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 17.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.place_outlined,
                              color: AppColors.grey5,
                              size: 20,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Text(
                                  "${vehicle.pickUp}",
                                  style: TextStyle(
                                    color: Color(0xFF717171),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            // Spacer(),

                            //TODO: EDIT BUTTON
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 16.0),
                            //   child: Text(
                            //     'Edit',
                            //     style: TextStyle(
                            //       decoration: TextDecoration.underline,
                            //       color: Colors.black,
                            //       fontSize: 14,
                            //       fontWeight: FontWeight.w500,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),

                      AppDivider(
                        height: 20,
                      ),
                      Text(
                        'Cancellation policy',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 17.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.place_outlined,
                              color: AppColors.grey5,
                              size: 20,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Free Cancellation',
                                      style: TextStyle(
                                        color: Color(0xFF717171),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 7.0),
                                      child: Text(
                                        'You get a full refund if you cancel 6 hours before the trip starts.',
                                        style: TextStyle(
                                          color: Color(0xFF717171),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // AppDivider(
                      //   height: 30,
                      // ),
                      // Text(
                      //   'Discounts',
                      //   style: TextStyle(
                      //     color: Colors.black,
                      //     fontSize: 14,
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      // ),

                      // Padding(
                      //   padding: const EdgeInsets.symmetric(vertical: 17.0),
                      //   child: Row(
                      //     children: [
                      //       Padding(
                      //         padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      //         child: Text(
                      //           '2+ day discount',
                      //           style: TextStyle(
                      //             color: Color(0xFF717171),
                      //             fontSize: 14,
                      //             fontWeight: FontWeight.w400,
                      //           ),
                      //         ),
                      //       ),
                      //       Spacer(),
                      //       Padding(
                      //         padding: const EdgeInsets.only(left: 16.0),
                      //         child: Text(
                      //           'N5,500',
                      //           style: TextStyle(
                      //             color: Color(0xFF239373),
                      //             fontSize: 14,
                      //             fontWeight: FontWeight.w500,
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),

                      // AppDivider(
                      //   height: 30,
                      // ),
                      // Text(
                      //   'Insurance provider',
                      //   style: TextStyle(
                      //     color: Colors.black,
                      //     fontSize: 14,
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      // ),

                      // Padding(
                      //   padding: const EdgeInsets.symmetric(vertical: 17.0),
                      //   child: Row(
                      //     children: [
                      //       Padding(
                      //         padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      //         child: Text(
                      //           'Smoke Assurance',
                      //           style: TextStyle(
                      //             color: Color(0xFF717171),
                      //             fontSize: 14,
                      //             fontWeight: FontWeight.w400,
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),

                      AppDivider(
                        height: 20,
                      ),

                      Text(
                        'Description',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                            // 'Extremely comfortable ride with plenty of front and back seat area. The car has a sport mode so you rev through lagos hustle in style. Feel free to bring back the car back unwashed, I will take care of the cleaning after.',
                            "${vehicle.description}",
                            style: AppTextStyles.input
                                .copyWith(color: Color(0xFF717171))),
                      ),

                      AppDivider(
                        height: 20,
                      ),

                      Text(
                        'Features',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                            children: vehicle.features.map((e) {
                          return BookingCarFeaturesRow(
                            icon: Icons.place_outlined,
                            text: e,
                          );
                        }).toList()),
                      ),

                      // AppOutlineButton(
                      //   title: 'View all 7 features',
                      //   onTap: () {
                      //     Navigator.push(
                      //       context,
                      //       StaarmPageRoute.routeTo(
                      //         builder: (context) => CarFeatureView(),
                      //       ),
                      //     );
                      //   },
                      // ),

                      SizedBox(height: 12),

                      // AppDivider(height: 20),

                      // Text(
                      //   'Ratings & Reviews',
                      //   style: TextStyle(
                      //     color: Colors.black,
                      //     fontSize: 14,
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      // ),

                      // SizedBox(height: 12),

                      // SingleChildScrollView(
                      //   scrollDirection: Axis.horizontal,
                      //   child: Row(
                      //     children: [
                      //       CarRatingsContainer(),
                      //       CarRatingsContainer(),
                      //       CarRatingsContainer(),
                      //     ],
                      //   ),
                      // ),
                      // AppOutlineButton(
                      //   title: 'Show all 25 reviews',
                      //   onTap: () {
                      //     Navigator.push(
                      //       context,
                      //       StaarmPageRoute.routeTo(
                      //         builder: (context) => RatingsView(),
                      //       ),
                      //     );
                      //   },
                      // ),

                      AppDivider(
                        height: 20,
                      ),

                      Text(
                        'Hosted by',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      SizedBox(height: 12),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            StaarmPageRoute.routeTo(
                              builder: (context) => CarOwnerProfileView(
                                owner: vehicle.vehicleOwner,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [

                            Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: vehicle.vehicleOwner.profilePic == null
                                  ? Icon(Icons.person_rounded)
                                  : Image.network(
                                      vehicle.vehicleOwner.profilePic,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "${vehicle.vehicleOwner.firstName} ${vehicle.vehicleOwner.lastName}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 6.0, bottom: 6),
                                  child: Text(
                                    // '${(vehicle.totalTrips != null && vehicle.totalTrips > 0) ? vehicle.totalTrips.toString() + ' trips' : '0'} trips ∙ Joined Jun 2021',
                                    '${(vehicle.totalTrips != null && vehicle.totalTrips > 0) ? vehicle.totalTrips.toString() + '' : '0'} trip(s)',
                                    style: TextStyle(
                                      color: Color(0xFF717171),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                                // Row(
                                //   children: [
                                //     Text(
                                //       '4.6',
                                //       style: TextStyle(
                                //         color: Colors.black,
                                //         fontSize: 14,
                                //         fontWeight: FontWeight.w500,
                                //       ),
                                //     ),
                                //     RatingsStarWidget(
                                //       count: 1,
                                //     ),
                                //   ],
                                // ),
                              ],
                            )
                          ],
                        ),
                      ),

                      AppDivider(
                        height: 20,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 9.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.place_outlined,
                              color: AppColors.grey5,
                              size: 20,
                            ),
                            SizedBox(width: 15),
                            Text(
                              'Guidelines',
                              style: TextStyle(
                                color: Color(0xFF231F20),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      AppDivider(
                        height: 20,
                      ),

                      SizedBox(height: size.height * .15),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomSheet: Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.04),
              offset: Offset(1, 0),
              blurRadius: 12,
            )
          ]),
          padding: EdgeInsets.only(
            bottom: 20,
            top: 4,
            left: 20,
            right: 20,
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    StaarmPageRoute.routeTo(
                      builder: (context) => PriceDetailsView(
                        price: vehicle.price,
                        tripEndDate: model.tripEndDate,
                        tripStartDate: model.tripStartDate,
                      ),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${StaarmFormatter.formatCurrencyInput(vehicle.price.toString())} / day',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        StaarmFormatter.formatCurrencyInput(
                                AppHelper.getTripAmountByPeriod(vehicle.price,
                                        model.tripStartDate, model.tripEndDate)
                                    .toString()) +
                            " est. total",
                        style: TextStyle(
                          color: Color(0xFF898989),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Consumer<UserProvider>(
                builder: (context, userProvider, _) => AppButton(
                  text: 'Continue',
                  textFontSize: 14,
                  onPressed: () {
                    //if user is not approved, take them to get Approved page

                    // if (!userProvider.isLoggedIn) {
                    //   StaarmModalHelpers.fullpageModal(
                    //     context,
                    //     child: LoginOrSignupView(
                    //       fromBooking: true,
                    //     ),
                    //     title: 'Log in or sign up',
                    //   );
                    // } else if (!userProvider.user.approved) {
                    //   userProvider.tempVehicle = vehicle;
                    //   userProvider.tempTripStartDate = model.tripStartDate;
                    //   userProvider.tempTripEndDate = model.tripEndDate;
                    //   userProvider.tempTripStartTime = model.tripStartTime;
                    //   userProvider.tempTripEndTime = model.tripEndTime;
                    //   userProvider.verifyingFromBookingScreen = true;

                    //   Navigator.push(
                    //     context,
                    //     StaarmPageRoute.routeTo(
                    //       builder: (context) => GetApprovedHome(),
                    //     ),
                    //   );
                    // } else {
                    //   Navigator.push(
                    //     context,
                    //     StaarmPageRoute.routeTo(
                    //       builder: (context) => SelectProtectionPlanView(
                    //         vehicle: vehicle,
                    //         tripStartDate: model.tripStartDate,
                    //         tripEndDate: model.tripEndDate,
                    //       ),
                    //     ),
                    //   );
                    // }

                    if (!userProvider.isLoggedIn) {
                      StaarmModalHelpers.fullpageModal(
                        context,
                        child: LoginOrSignupView(
                          fromBooking: true,
                        ),
                        title: 'Log in or sign up',
                      );
                    } else {
                      Navigator.push(
                        context,
                        StaarmPageRoute.routeTo(
                          builder: (context) => SelectProtectionPlanView(
                            vehicle: vehicle,
                            tripStartDate: model.tripStartDate,
                            tripEndDate: model.tripEndDate,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CarRatingsContainer extends StatelessWidget {
  const CarRatingsContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: 160,
      width: size.width * .7,
      margin: EdgeInsets.only(right: 13),
      padding: EdgeInsets.symmetric(
        vertical: 13,
        horizontal: 18,
      ),
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF231F20)),
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration:
                    BoxDecoration(color: Colors.black, shape: BoxShape.circle),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 13.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Yinka',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: Text(
                            '13 Jul 2021',
                            style: TextStyle(
                              color: Color(0xFF717171),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    RatingsStarWidget(
                      count: 5,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10),
            child: Text(
              'Perfect trip with this car when I expereinced Abuja for the first time. Great and fast pick up, would definitely always call for this  car.',
              style: TextStyle(
                color: Color(0xFF717171),
                fontSize: 14,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BookingCarFeaturesRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const BookingCarFeaturesRow({
    Key key,
    @required this.icon,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.grey5,
            size: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              text,
              style: TextStyle(
                color: Color(0xFF717171),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
