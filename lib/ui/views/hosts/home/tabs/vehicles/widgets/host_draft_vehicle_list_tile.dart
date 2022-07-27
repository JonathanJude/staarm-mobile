import 'package:flutter/material.dart';
import 'package:staarm_mobile/core/models/host_draft_vehicle.dart';
import 'package:staarm_mobile/ui/views/hosts/select_car/select_car_1/select_car_1.dart';
import 'package:staarm_mobile/utils/staarm_page_route.dart';

class HostDraftVehicleListTile extends StatefulWidget {
  final HostDraftVehicleModel vehicle;

  const HostDraftVehicleListTile({
    Key key,
    @required this.vehicle,
  }) : super(key: key);

  @override
  State<HostDraftVehicleListTile> createState() =>
      _HostDraftVehicleListTileState();
}

class _HostDraftVehicleListTileState extends State<HostDraftVehicleListTile> {
  // bool isCancelled;

  // @override
  // initState() {
  //   super.initState();
  //   isCancelled = widget.isCancelled;
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          StaarmPageRoute.routeTo(
            builder: (context) => SelectCar1View(
              hostVehicle: widget.vehicle,
            ),
          ),
        );
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
                  width: 100,
                  child: Container(),
                  // child: Image.network(
                  //     widget.trip.vehicle.vehiclePhotos.first.url,
                  //     ),
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
                          widget.vehicle.fullName ?? '',
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
                          widget.vehicle.licenceNumber ?? '',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color(0xFF757D8A),
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      // SizedBox(height: 3),
                      // Text(
                      //   '(165 trips)',
                      //   textAlign: TextAlign.left,
                      //   style: TextStyle(
                      //     color: Color(0xFF757D8A),
                      //     fontWeight: FontWeight.w400,
                      //     fontSize: 12,
                      //   ),
                      // ),
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
