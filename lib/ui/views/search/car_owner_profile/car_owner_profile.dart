import 'package:flutter/material.dart';
import 'package:staarm_mobile/core/models/vehicle/vehicle_owner.dart';
import 'package:staarm_mobile/ui/base/base_view.dart';
import 'package:staarm_mobile/ui/views/search/widgets/search_car_widget.dart';
import 'package:staarm_mobile/ui/views/trips/trips_empty_state.dart';
import 'package:staarm_mobile/widgets/app_divider.dart';
import 'package:staarm_mobile/widgets/buttons/underline_flat_button.dart';
import 'package:staarm_mobile/widgets/indicators/staarm_shimmers.dart';

import 'view_model.dart';

class CarOwnerProfileView extends StatelessWidget {
  final VehicleOwner owner;
  const CarOwnerProfileView({Key key, @required this.owner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<CarOwnerProfileViewModel>(
      model: CarOwnerProfileViewModel(),
      onModelReady: (model) => model.init(owner.id),
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Color(0xFF717171),
          ),
          title: Text(
            'Profile',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 17,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
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
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: owner.profilePic == null
                                ? Icon(Icons.person_rounded)
                                : Image.network(
                                    owner.profilePic,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                    ),
                    // CircleAvatar(
                    //   backgroundImage:
                    //       AssetImage('assets/images/mock_images/man_image.png'),
                    //   maxRadius: 35,
                    //   minRadius: 25,
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(left: 13.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hi, I’m ${owner.firstName}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(top: 6.0),
                              //   child: Text(
                              //     'Joined Dec 2020  165 trips',
                              //     style: TextStyle(
                              //       color: Color(0xFF717171),
                              //       fontSize: 12,
                              //       fontWeight: FontWeight.w400,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Text(
                    'About ${owner.firstName}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Text(
                    '${owner.about}',
                    // 'My journey as a Staarm host started in 2020 in Lagos. At the tim, I owned 3 Cars but i really didn’t even need to have acr because Lagos is such a walkable city. I didn’t want t  sell any of my cars but I did not want them sitting idle in my compound. Making a little cash... ',
                    style: TextStyle(
                      color: Color(0xFF717171),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Center(
                  child: UnderlineFlatButton(
                    text: 'View all',
                    onTap: () {},
                  ),
                ),
                SizedBox(height: 15),
                AppDivider(),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Text(
                    'Verified Information',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                if (owner.email != null && owner.email.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      'Email address',
                      style: TextStyle(
                        color: Color(0xFF717171),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    'Phone number',
                    style: TextStyle(
                      color: Color(0xFF717171),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                AppDivider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Text(
                    "${owner.firstName}'s vehicles",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                 model.isLoading
                      ? StaarmShimmers.loadCars() :
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: model.ownerVehicles.length > 0
                          ? Row(
                              children: model.ownerVehicles.map((e) {
                              return SearchCarWidget(
                                widthFactor: .7,
                                vehicle: e,
                                selectDate: true,
                              );
                            }).toList())
                          : TripsEmptyState(
                              image: 'assets/images/book_icon.png',
                              title:
                                  '${owner.firstName} has not posted any vehicle yet',
                              subtitle: '',
                            ),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 12.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       UnderlineFlatButton(
                //         onTap: () {},
                //         text: 'View all vehicles',
                //       ),
                //       SizedBox(width: 12),
                //       Icon(Icons.keyboard_arrow_right)
                //     ],
                //   ),
                // ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
