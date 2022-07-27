import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:staarm_mobile/core/models/host_draft_vehicle.dart';
import 'package:staarm_mobile/ui/base/base_view.dart';
import 'package:staarm_mobile/utils/app_helper.dart';
import 'package:staarm_mobile/widgets/address_search_container.dart';
import 'package:staarm_mobile/widgets/buttons/app_button.dart';
import 'package:staarm_mobile/widgets/textfields/normal_auth_textfield.dart';

import 'view_model.dart';

class SelectCar3View extends StatefulWidget {
  final String draftId;
  final HostDraftVehicleModel hostVehicle;
  const SelectCar3View({Key key, @required this.draftId, this.hostVehicle}) : super(key: key);

  @override
  _SelectCar3ViewState createState() => _SelectCar3ViewState();
}

class _SelectCar3ViewState extends State<SelectCar3View> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BaseView<SelectCar3ViewModel>(
      model: SelectCar3ViewModel(),
      onModelReady: (model) => model.init(widget.draftId, widget.hostVehicle),
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
                      'Pick up & drop off points',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 17),
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
                        Flexible(
                          child: Text(
                            'It is advisable to use public locations close to your vicinity for pick ups and drop-offs such as eateries, filling stations etc.',
                            style: TextStyle(
                              color: Color(0xFF757D8A),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  NormalAuthTextField(
                    labelText: 'Pick-up location',
                    controller: model.pickUpLocationTextController,
                    onChanged: (str) => model.onPickUpChanged(str),
                  ),
                  if (model.pickUpPlaces.length > 0)
                    AddressSearchContainer(
                      places: model.pickUpPlaces,
                      onPlaceSelected: (plc) {
                        model.onPickUpSelected(plc);
                      },
                    ),
                  SizedBox(height: 20),
                  NormalAuthTextField(
                    labelText: 'Drop off location',
                    controller: model.dropOffLocationTextController,
                    onChanged: (str) => model.onDropOffChanged(str),
                  ),
                  if (model.dropOffPlaces.length > 0)
                    AddressSearchContainer(
                      places: model.dropOffPlaces,
                      onPlaceSelected: (plc) {
                        model.onDropOffSelected(plc);
                      },
                    ),
                  SizedBox(height: size.height * .19),
                ],
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
                      model.updateVehiclePickOffAndDropOffLocation(widget.hostVehicle);
                      // Navigator.push(
                      //   context,
                      //   StaarmPageRoute.routeTo(
                      //     builder: (context) => SelectCar4View(),
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
