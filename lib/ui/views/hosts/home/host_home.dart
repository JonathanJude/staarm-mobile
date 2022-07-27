import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staarm_mobile/core/providers/vehicle_provider.dart';
import 'package:staarm_mobile/styles/colors.dart';
import 'package:staarm_mobile/ui/views/hosts/get_started_hosts/get_started_hosts.dart';
import 'package:staarm_mobile/ui/views/hosts/home/tabs/vehicles/vehicles.dart';
import 'package:staarm_mobile/utils/staarm_page_route.dart';

import '../loading_hosts.dart';

class HostsHomeView extends StatelessWidget {
  const HostsHomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<VehicleProvider>(
      builder: (context, vehicleProvider, _) =>
          vehicleProvider.isSyncingHostsVehicles
              ? LoadingHostsView()
              : !vehicleProvider.isHostVehicleAvailable
                  ? GetStartedHostsView()
                  : DefaultTabController(
                      length: 1,
                      child: Scaffold(
                        backgroundColor: AppColors.appBackground,
                        appBar: AppBar(
                          backgroundColor: AppColors.appBackground,
                          elevation: 0,
                          automaticallyImplyLeading: false,
                          centerTitle: true,
                          title: Text(
                            'Hosts',
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
                                  text: 'Vehicles',
                                ),
                                // Tab(
                                //   text: 'Earnings',
                                // ),
                              ]),
                        ),
                        body: TabBarView(
                          children: [
                            HostsVehicleTab(),
                            // HostsEarningsTab(),
                          ],
                        ),
                        floatingActionButton: vehicleProvider.isHostVehicleAvailable ? FloatingActionButton(
                          backgroundColor: AppColors.primaryColor,
                          child: Icon(Icons.add),
                          onPressed: () {
                            Navigator.push(
                              context,
                              StaarmPageRoute.routeTo(
                                builder: (context) => GetStartedHostsView(
                                  showNavIcon: true,
                                ),
                              ),
                            );
                          },
                        ) : SizedBox(),
                      ),
                    ),
    );
  }
}
