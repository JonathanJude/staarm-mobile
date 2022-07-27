import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staarm_mobile/core/models/host_draft_vehicle.dart';
import 'package:staarm_mobile/core/models/vehicle/vehicle_info_model.dart';
import 'package:staarm_mobile/core/providers/vehicle_provider.dart';
import 'package:staarm_mobile/ui/base/base_view.dart';
import 'package:staarm_mobile/utils/app_helper.dart';
import 'package:staarm_mobile/values/dropdown_values.dart';
import 'package:staarm_mobile/widgets/app_dropdown_container.dart';
import 'package:staarm_mobile/widgets/buttons/app_button.dart';
import 'package:staarm_mobile/widgets/textfields/normal_auth_textfield.dart';

import 'view_model.dart';

class SelectCar2View extends StatefulWidget {
  final HostDraftVehicleModel hostVehicle;
  final VehicleMake vehicle;
  final String model;
  final String year;
  final String draftId;

  const SelectCar2View({
    Key key,
    this.hostVehicle,
    @required this.vehicle,
    @required this.model,
    @required this.year,
    @required this.draftId,
  }) : super(key: key);

  @override
  _SelectCar2ViewState createState() => _SelectCar2ViewState();
}

class _SelectCar2ViewState extends State<SelectCar2View> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BaseView<SelectCar2ViewModel>(
      model: SelectCar2ViewModel(),
      onModelReady: (model) => model.init(widget.draftId, widget.hostVehicle),
      builder: (context, model, _) => SafeArea(
        bottom: false,
        top: false,
        child: Scaffold(
          body: Consumer<VehicleProvider>(
            builder: (context, vehicleProvider, _) => SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 17,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height * .05),
                    GestureDetector(
                      onTap: () {
                        AppHelper.cancelVehicleCreation(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18.0),
                        child: Icon(
                          Icons.clear,
                          color: Color(0xFF757D8A),
                          size: 27,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      child: Text(
                        'Tell us more about your car.',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 17),
                    AppDropdownButton(
                        hint: 'Transmission',
                        value: model.transmission,
                        onTap: () {
                          AppHelper.showPicker(context,
                              items: vehicleProvider.vehicleData.transmissions,
                              dropdownItem: vehicleProvider
                                  .vehicleData.transmissions
                                  .map((e) => Text(e))
                                  .toList(), onSelect: (val) {
                            model.transmission = val;
                          });
                        }),
                    AppDropdownButton(
                        hint: 'Odometer',
                        value: model.odometer,
                        onTap: () {
                          AppHelper.showPicker(context,
                              items: vehicleProvider.vehicleData.odometers,
                              dropdownItem: vehicleProvider
                                  .vehicleData.odometers
                                  .map((e) => Text(e))
                                  .toList(), onSelect: (val) {
                            model.odometer = val;
                          });
                        }),
                    AppDropdownButton(
                        hint: 'Vehicle type',
                        value: model.vehicleType,
                        onTap: () {
                          AppHelper.showPicker(context,
                              items: vehicleProvider.vehicleData.types,
                              dropdownItem: vehicleProvider.vehicleData.types
                                  .map((e) => Text(e))
                                  .toList(), onSelect: (val) {
                            setState(() {
                              model.vehicleType = val;
                            });
                          });
                        }),
                    AppDropdownButton(
                        hint: 'Market value',
                        value: model.marketValue,
                        onTap: () {
                          AppHelper.showPicker(context,
                              items: vehicleProvider.vehicleData.marketValues,
                              dropdownItem: vehicleProvider
                                  .vehicleData.marketValues
                                  .map((e) => Text(e))
                                  .toList(), onSelect: (val) {
                            model.marketValue = val;
                          });
                        }),
                    SizedBox(height: 20),
                    Text(
                      'Licence plate',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      margin: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFF8F8F8),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Color(0xFF757D8A),
                            size: 18,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Your plate number won’t be publicly visible.',
                            style: TextStyle(
                              color: Color(0xFF757D8A),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    NormalAuthTextField(
                      labelText: 'Licence plate number',
                      controller: model.licenseNumberTextController,
                      onChanged: (str) {
                        model.licenceNumber = str;
                      },
                    ),
                    AppDropdownButton(
                        hint: 'State',
                        value: model.selectedState,
                        onTap: () {
                          AppHelper.showPicker(context,
                              dropdownItem: DropDownValues.states
                                  .map((e) => Text(e))
                                  .toList(),
                              items: DropDownValues.states, onSelect: (val) {
                            model.selectedState = val;
                          });
                        }),
                    SizedBox(height: size.height * .19),
                  ],
                ),
              ),
            ),
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
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Back',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Flexible(
                  child: AppButton(
                    color: Colors.black,
                    isLoading: model.isLoading,
                    onPressed: () {
                      model.updateVehicleDetails();

                      // Navigator.push(
                      //   context,
                      //   StaarmPageRoute.routeTo(
                      //     builder: (context) => SelectCar3View(
                      //       draftId: 'vehicleDraftId',
                      //     ),
                      //   ),
                      // );
                    },
                    text: 'Next',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
