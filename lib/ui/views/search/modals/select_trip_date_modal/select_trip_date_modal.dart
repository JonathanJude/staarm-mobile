import 'package:flutter/material.dart';
import 'package:staarm_mobile/core/models/address_model.dart';
import 'package:staarm_mobile/ui/base/base_view.dart';
import 'package:staarm_mobile/utils/app_helper.dart';
import 'package:staarm_mobile/widgets/buttons/app_button.dart';
import 'package:staarm_mobile/widgets/buttons/auth_dob_button.dart';
import 'package:staarm_mobile/widgets/buttons/bottom_app_button_container.dart';

import '../../../../../widgets/app_divider.dart';
import 'view_model.dart';

class SelectTripDateModalView extends StatelessWidget {
  final AddressModel address;
  final DateTime iPickupDate;
  final DateTime iPickupTime;
  final DateTime iReturnDate;
  final DateTime iReturnTime;
  final Function(DateTime, DateTime, DateTime, DateTime) onSelect;
  const SelectTripDateModalView({
    Key key,
    @required this.address,
    this.onSelect,
    this.iPickupDate,
    this.iPickupTime,
    this.iReturnDate,
    this.iReturnTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<SelectTripDateModalViewModel>(
      model: SelectTripDateModalViewModel(),
      onModelReady: (model) =>
          model.init(iPickupDate, iPickupTime, iReturnDate, iReturnTime),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 5,
                      width: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(0xFFDDDDDD),
                      ),
                    ),
                  ),
                  // SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Text(
                              'When will you need the car?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppDivider(
                    color: Color(0xFFE7E7E8),
                    height: 1,
                  ),
                  SizedBox(height: 7),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            'Pick-up',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: AuthDOBButton(
                                text: model
                                    .formattedDate(model.selectedPickupDate),
                                onTap: () => AppHelper.showDatePicker(context,
                                    currentDate: model.selectedPickupDate,
                                    minDate:
                                        DateTime.now().add(Duration(days: 1)),
                                    onSelected: (d) {
                                  model.selectedPickupDate = d;
                                }),
                                title: 'Date',
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: AuthDOBButton(
                                text: model
                                    .formattedTime(model.selectedPickupTime),
                                onTap: () => AppHelper.showTimePicker(context,
                                    currentTime: model.selectedPickupTime,
                                    onSelected: (d) {
                                  model.selectedPickupTime = d;
                                }),
                                title: 'Time',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            'Return',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: AuthDOBButton(
                                text: model
                                    .formattedDate(model.selectedReturnDate),
                                onTap: () => AppHelper.showDatePicker(context,
                                    currentDate: model.selectedReturnDate,
                                    minDate: model.selectedPickupDate,
                                    onSelected: (d) {
                                  model.selectedReturnDate = d;
                                }),
                                title: 'Date',
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: AuthDOBButton(
                                text: model
                                    .formattedTime(model.selectedReturnTime),
                                onTap: () => AppHelper.showTimePicker(context,
                                    currentTime: model.selectedReturnTime,
                                    onSelected: (d) {
                                  model.selectedReturnTime = d;
                                }),
                                title: 'Time',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomSheet: BottomAppButtonContainer(
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      model.reset();
                    },
                    child: Text(
                      'Reset',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Flexible(
                child: AppButton(
                  icon: Icons.search,
                  isLoading: model.isLoading,
                  onPressed: () {
                    if (onSelect != null) {
                      onSelect(
                        model.selectedPickupDate,
                        model.selectedPickupTime,
                        model.selectedReturnDate,
                        model.selectedReturnTime,
                      );
                    } else {
                      model.search(address);
                    }
                  },
                  text: onSelect != null ? 'Next' : 'Search',
                  textFontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
