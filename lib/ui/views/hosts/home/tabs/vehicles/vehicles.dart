import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staarm_mobile/core/models/host_draft_vehicle.dart';
import 'package:staarm_mobile/core/models/vehicle/vehicle_model.dart';
import 'package:staarm_mobile/core/providers/vehicle_provider.dart';
import 'package:staarm_mobile/ui/base/base_view.dart';

import 'view_model.dart';
import 'widgets/host_draft_vehicle_list_tile.dart';
import 'widgets/host_vehicle_list_tile.dart';

class HostsVehicleTab extends StatefulWidget {
  const HostsVehicleTab({Key key}) : super(key: key);

  @override
  _HostsVehicleTabState createState() => _HostsVehicleTabState();
}

class _HostsVehicleTabState extends State<HostsVehicleTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BaseView<HostsVehicleTabViewModel>(
      model: HostsVehicleTabViewModel(),
      onModelReady: (model) => model.getVehicles(),
      builder: (context, model, _) {
        // if (model.isLoading || model.vehicles == null) {
        //   return StaarmShimmers.loadCars();
        // }

        // List<VehicleModel> vehicles = model.vehicles;

        // if (vehicles.isEmpty) {
        //   return TripsEmptyState(
        //     image: 'assets/images/book_icon.png',
        //     title: 'You have no bookings yet',
        //     subtitle:
        //         'Plan a new trip and drive to any place with a ride of your choice. ',
        //   );
        // }

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Consumer<VehicleProvider>(
                  builder: (context, vehicleProvider, _) => Column(
                    children: [
                      if(vehicleProvider.isHostDraftVehicleAvailable)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 13.0),
                        child: Text(
                          'Draft (${vehicleProvider.hostVehicles.draftVehicles.length})',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF231F20),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      if(vehicleProvider.isHostDraftVehicleAvailable)
                      Column(
                        children: List.generate(
                          vehicleProvider.hostVehicles.draftVehicles.length,
                          (index) {
                            HostDraftVehicleModel b = vehicleProvider.hostVehicles.draftVehicles[index];

                            return HostDraftVehicleListTile(
                              vehicle: b,
                            );
                          },
                        ),
                      ),


                      //listed vehicles
                      if(vehicleProvider.isHostListedVehicleAvailable)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 13.0),
                        child: Text(
                          'Listed (${vehicleProvider.hostVehicles.listedVehicles.length})',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF231F20),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      if(vehicleProvider.isHostListedVehicleAvailable)
                      Column(
                        children: List.generate(
                          vehicleProvider.hostVehicles.listedVehicles.length,
                          (index) {
                            VehicleModel b = vehicleProvider.hostVehicles.listedVehicles[index];
                            return HostListedVehicleListTile(
                              vehicle: b,
                            );
                          },
                        ),
                      )
                    ],
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
