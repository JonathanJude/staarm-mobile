import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staarm_mobile/core/models/host_draft_vehicle.dart';
import 'package:staarm_mobile/core/models/vehicle/vehicle_info_model.dart';
import 'package:staarm_mobile/core/providers/vehicle_provider.dart';
import 'package:staarm_mobile/ui/base/base_view.dart';
import 'package:staarm_mobile/utils/app_helper.dart';
import 'package:staarm_mobile/widgets/app_dropdown_container.dart';
import 'package:staarm_mobile/widgets/buttons/app_button.dart';

import 'view_model.dart';

class SelectCar1View extends StatefulWidget {
  final HostDraftVehicleModel hostVehicle;
  const SelectCar1View({Key key, this.hostVehicle}) : super(key: key);

  @override
  _SelectCar1ViewState createState() => _SelectCar1ViewState();
}

class _SelectCar1ViewState extends State<SelectCar1View> {
  static int _currentYear = DateTime.now().year;

  List<String> _yearList =
      new List<String>.generate(60, (i) => (_currentYear - (i - 1)).toString());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BaseView<SelectCar1ViewModel>(
      model: SelectCar1ViewModel(),
      onModelReady: (model) => model.init(widget.hostVehicle),
      builder: (context, model, _) => SafeArea(
        bottom: false,
        top: false,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 17,
              ),
              child: Consumer<VehicleProvider>(
                builder: (context, vehicleProvider, _) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height * .05),
                    GestureDetector(
                      onTap: () {
                        // AppHelper.cancelVehicleCreation(context);
                        Navigator.of(context).pop();
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
                        'Describe your car.',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 17),
                    AppDropdownButton(
                        hint: 'Car Make',
                        value: model.selectedCarMake?.make,
                        onTap: () {
                          AppHelper.showPicker<VehicleMake>(context,
                              items: vehicleProvider.vehicleData.vehicleMakes,
                              dropdownItem:
                                  vehicleProvider.vehicleData.vehicleMakes
                                      .map(
                                        (e) => Text(
                                          e.make,
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      )
                                      .toList(), onSelect: (val) {
                            setState(() {
                              model.selectedCarMake = val;
                              model.selectedModel = null;
                            });
                          });
                        }),
                    AppDropdownButton(
                        hint: 'Car Model',
                        value: model.selectedModel,
                        onTap: model.selectedCarMake == null
                            ? null
                            : () {
                                AppHelper.showPicker<String>(context,
                                    items: model.selectedCarMake.models,
                                    dropdownItem: model.selectedCarMake.models
                                        .map(
                                          (e) => Text(
                                            e,
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        )
                                        .toList(), onSelect: (val) {
                                  setState(() {
                                    model.selectedModel = val;
                                  });
                                });
                              }),
                    AppDropdownButton(
                        hint: 'Car Year',
                        value: model.vehicleYear,
                        onTap: () {
                          AppHelper.showPicker(context,
                              items: vehicleProvider.vehicleData.years,
                              dropdownItem: vehicleProvider.vehicleData.years
                                  .map((e) => Text(e.toString()))
                                  .toList(), onSelect: (val) {
                            setState(() {
                              model.vehicleYear = val.toString();
                            });
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
                    disabled: model.selectedModel == null &&
                        model.selectedCarMake == null &&
                        (model.vehicleYear == null ||
                            model.vehicleYear.isEmpty),
                    onPressed: () {
                      model.startVehicleHosting(widget.hostVehicle);
                      // Navigator.push(
                      //   context,
                      //   StaarmPageRoute.routeTo(
                      //     builder: (context) => SelectCar2View(
                      //       vehicle: model.selectedVehicle,
                      //       model: model.selectedModel,
                      //       year: model.vehicleYear,
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
