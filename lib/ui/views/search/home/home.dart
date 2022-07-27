import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:staarm_mobile/core/providers/location_provider.dart';
import 'package:staarm_mobile/ui/base/base_view.dart';
import 'package:staarm_mobile/ui/views/search/modals/location_search_modal/location_search_modal.dart';
import 'package:staarm_mobile/ui/views/search/widgets/search_car_widget.dart';
import 'package:staarm_mobile/widgets/indicators/staarm_shimmers.dart';

import '../../../../values/images.dart';
import '../widgets/become_a_host_widget.dart';
import '../widgets/search_page_info.dart';
import '../widgets/search_top_banner.dart';
import 'view_model.dart';

class SearchHomeView extends StatelessWidget {
  const SearchHomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BaseView<SearchHomeViewModel>(
      model: SearchHomeViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, _) => Scaffold(
          body: Consumer<LocationProvider>(
        builder: (context, locationProvider, _) => CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              titleSpacing: 10,
              toolbarHeight: kToolbarHeight + 15,
              centerTitle: true,
              title: Column(
                children: [
                  SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      // model.loadAssets();
                      showCupertinoModalBottomSheet(
                        expand: true,
                        context: context,
                        isDismissible: false,
                        useRootNavigator: true,
                        enableDrag: false,
                        backgroundColor: Colors.transparent,
                        builder: (context) => LocationSearchView(),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      padding:
                          EdgeInsets.symmetric(vertical: 13, horizontal: 26),
                      decoration: BoxDecoration(
                        color: Color(0xFFF7F7F7),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                          Text(
                            'Ready to go?',
                            style: TextStyle(
                                color: Color(0xFF231F20),
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              pinned: true,
              // floating: true,
              expandedHeight: 300.0,
              flexibleSpace: FlexibleSpaceBar(
                background: SearchTopBanner(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),

                    if (model.isLoading)
                      StaarmShimmers.loadCars()
                    else if (locationProvider.isLocationAvailable &&
                        model.vehiclesCloseBy != null &&
                        model.vehiclesCloseBy.length > 0)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Explore cars nearby',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 10),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                children: model.vehiclesCloseBy.map((e) {
                              return SearchCarWidget(
                                widthFactor: .7,
                                vehicle: e,
                                selectDate: true,
                              );
                            }).toList()),
                          ),
                        ],
                      ),

                    SizedBox(height: 30),

                    Center(
                      child: GestureDetector(
                        onTap: () {
                          model.showMetaMapFlow();
                        },
                        child: Text(
                          "**MetaMap Verification**",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),

                    //expl
                    SearchPageInfo(
                      image: AppImages.callSupportIcon,
                      title: 'Support',
                      subtitle:
                          'Rest easy knowing the Staarm community is pre-screened, and the customer support  are just a click away.',
                    ),

                    SearchPageInfo(
                      image: AppImages.optionIcon,
                      title: 'Options',
                      subtitle:
                          'Choose from hundreds of models you won’t find anywhere else. Pick it up or get it delivered where you want it.',
                    ),

                    SearchPageInfo(
                      image: AppImages.securedIcon,
                      title: 'Secured',
                      subtitle:
                          'Drive confidently with your choice of protection plans - all plans include varying levels of liability insurance.',
                    ),

                    SizedBox(height: 20),

                    //become a host widget
                    BecomeAHostWidget(),

                    SizedBox(height: 30),
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
