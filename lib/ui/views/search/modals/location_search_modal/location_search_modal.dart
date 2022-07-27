import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:staarm_mobile/core/providers/location_provider.dart';
import 'package:staarm_mobile/ui/base/base_view.dart';

import '../../../../../styles/textstyles.dart';
import '../../../../../widgets/app_divider.dart';
import '../../widgets/search_result_tile.dart';
import 'view_model.dart';

class LocationSearchView extends StatelessWidget {
  const LocationSearchView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<LocationSearchViewModel>(
      model: LocationSearchViewModel(),
      builder: (context, model, _) => Scaffold(
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.only(top: 0),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF202046).withOpacity(.08),
                    blurRadius: 8,
                    spreadRadius: 0,
                    offset: Offset(0, -6),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 5,
                    width: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xFFDDDDDD),
                    ),
                  ),
                  // SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 15),
                        Padding(
                          padding: const EdgeInsets.only(left: 14.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(Icons.arrow_back_ios,
                                color: Color(0xFF717171), size: 22),
                          ),
                        ),

                        Expanded(
                          child: TextField(
                            onChanged: (str) => model.onPickUpChanged(str),
                            cursorColor: Colors.black,
                            controller: model.locationTextController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              hintText: 'Where do you need the car?',
                              hintStyle: AppTextStyles.input.copyWith(
                                color: Color(0xFFB0B0B0),
                              ),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    model.clearSearch();
                                    // if (onClose != null) {
                                    //   onClose();
                                    // } else {
                                    //   Navigator.of(context).pop();
                                    // }
                                  },
                                  child: Icon(Icons.clear,
                                      color: Colors.black, size: 25),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Padding(
                        //   padding: const EdgeInsets.only(right: 14.0),
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       // if (onClose != null) {
                        //       //   onClose();
                        //       // } else {
                        //       //   Navigator.of(context).pop();
                        //       // }
                        //     },
                        //     child: Icon(Icons.clear,
                        //         color: Colors.black, size: 25),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  AppDivider(
                    color: Color(0xFFE7E7E8),
                    height: 1,
                  ),
                  SizedBox(height: 7),

                  //child

                  // if(model.pickUpPlaces.length > 0)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: model.pickUpPlaces.length == 0
                          ? [
                              Consumer<LocationProvider>(
                                builder: (context, locProvider, _) => locProvider.isLocationAvailable ? SearchResultTile(
                                  title: 'Explore hosts nearby',
                                  color: Color(0xFF824DFF).withOpacity(.12),
                                  iconColor: Color(0xFF824DFF),
                                  icon: MdiIcons.compassOutline,
                                  onTap: () {
                                    model.onExploreHostsNearby();
                                  },
                                ) : SizedBox(),
                              )
                            ]
                          : model.pickUpPlaces.map((e) {
                              return SearchResultTile(
                                title: e.name,
                                onTap: () {
                                  model.onPickUpSelected(e);
                                },
                              );
                            }).toList(),
                    ),

                    // model.pickUpPlaces.map((e) {
                    //   return  SearchResultTile(
                    //     title: e.name,
                    //     onTap: (){
                    //       model.onPickUpSelected(e);
                    //     },
                    //   );
                    //   // return SearchResultTile(
                    //   //   title: 'Explore hosts nearby',
                    //   //   color: Color(0xFF824DFF).withOpacity(.12),
                    //   //   iconColor: Color(0xFF824DFF),
                    //   //   icon: MdiIcons.compassOutline,
                    //   // );
                    // }).toList(),

                    // [
                    //   SearchResultTile(
                    //     title: 'Explore hosts nearby',
                    //     color: Color(0xFF824DFF).withOpacity(.12),
                    //     iconColor: Color(0xFF824DFF),
                    //     icon: MdiIcons.compassOutline,
                    //   ),
                    //   // Text(
                    //   //   'Recent Searches',
                    //   //   style: TextStyle(
                    //   //     color: Color(0xFF231F20),
                    //   //     fontSize: 14,
                    //   //     fontWeight: FontWeight.w700,
                    //   //   ),
                    //   // ),
                    //   SearchResultTile(
                    //     title: 'Yaba, Lagos',
                    //     subtitle: '3 Jul - 4 Jul',
                    //     icon: MdiIcons.clockOutline,
                    //     onTap: () {
                    //       Navigator.pushReplacement(
                    //         context,
                    //         StaarmPageRoute.routeTo(
                    //           builder: (context) => SearchCarsView(),
                    //         ),
                    //       );
                    //     },
                    //   ),
                    //   SearchResultTile(
                    //     title: 'Lekki, Lagos',
                    //     subtitle: '3 Jul - 4 Jul',
                    //   ),
                    //   SearchResultTile(
                    //     title: 'Lekki, Lagos',
                    //   ),
                    // ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
