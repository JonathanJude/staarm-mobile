import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:staarm_mobile/core/models/host_draft_vehicle.dart';
import 'package:staarm_mobile/ui/base/base_view.dart';
import 'package:staarm_mobile/utils/app_helper.dart';
import 'package:staarm_mobile/utils/text_utils/thousand_separator_input_formatter.dart';
import 'package:staarm_mobile/widgets/buttons/app_button.dart';
import 'package:staarm_mobile/widgets/textfields/normal_auth_textfield.dart';

import 'view_model.dart';

class SelectCar4View extends StatefulWidget {
  final String draftId;
  final HostDraftVehicleModel hostVehicle;
  const SelectCar4View({Key key, @required this.draftId, this.hostVehicle}) : super(key: key);

  @override
  _SelectCar4ViewState createState() => _SelectCar4ViewState();
}

class _SelectCar4ViewState extends State<SelectCar4View> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BaseView<SelectCar4ViewModel>(
      model: SelectCar4ViewModel(),
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
                      'Pricing',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    'How much would you like to lease your car daily?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 17),
                  NormalAuthTextField(
                    labelText: 'Daily price',
                    controller: model.pricingTextController,
                    textInputType: TextInputType.number,
                    inputFormatters: [
                      ThousandsSeparatorInputFormatter()
                    ],
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
                      model.updateVehiclePricing(widget.hostVehicle);

                      // Navigator.push(
                      //   context,
                      //   StaarmPageRoute.routeTo(
                      //     builder: (context) => CarFeatures(),
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
