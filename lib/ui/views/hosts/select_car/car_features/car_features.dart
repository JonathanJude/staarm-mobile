import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:staarm_mobile/core/models/host_draft_vehicle.dart';
import 'package:staarm_mobile/ui/base/base_view.dart';
import 'package:staarm_mobile/ui/views/hosts/select_car/car_features/widgets/car_feature_item.dart';
import 'package:staarm_mobile/utils/app_helper.dart';
import 'package:staarm_mobile/widgets/buttons/app_button.dart';

import 'view_model.dart';

class CarFeatures extends StatefulWidget {
  final String draftId;
  final HostDraftVehicleModel hostVehicle;
  const CarFeatures({Key key, @required this.draftId, this.hostVehicle}) : super(key: key);

  @override
  _CarFeaturesState createState() => _CarFeaturesState();
}

class _CarFeaturesState extends State<CarFeatures> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BaseView<CarFeaturesViewModel>(
      model: CarFeaturesViewModel(),
      onModelReady: (model) => model.init(widget.draftId, widget.hostVehicle),
      builder: (context, model, _) => SafeArea(
        bottom: false,
        top: false,
        child: Scaffold(
          body: SingleChildScrollView(
            controller: model.scrollController,
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
                      'Car features',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    child: Text(
                      'What car features make your stand out?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  GridView.count(
                    controller: model.scrollController,
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    childAspectRatio: 1.6,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 12,
                    children: model.featuresList1
                        .map(
                          (e) => CarFeatureItem(
                            onTap: () => model.onSelectFeature(e),
                            text: e,
                            selected: model.isSelected(e),
                          ),
                        )
                        .toList(),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(
                  //     vertical: 5,
                  //   ),
                  //   child: Text(
                  //     'Does your car with any of theses',
                  //     style: TextStyle(
                  //       color: Colors.black,
                  //       fontSize: 16,
                  //       fontWeight: FontWeight.w600,
                  //     ),
                  //   ),
                  // ),
                  // GridView.count(
                  //   controller: model.scrollController,
                  //   crossAxisCount: 2,
                  //   shrinkWrap: true,
                  //   childAspectRatio: 1.9,
                  //   mainAxisSpacing: 10,
                  //   crossAxisSpacing: 12,
                  //   children: model.featuresList2
                  //       .map((e) => CarFeatureItem(
                  //             onTap: () => model.onSelectFeature(e),
                  //             text: e,
                  //             selected: model.isSelected(e),
                  //           ))
                  //       .toList(),
                  // ),
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
                    disabled: model.selectedfeatures.length == 0,
                    isLoading: model.isLoading,
                    onPressed: () {
                      model.updateVehicleFeatures(widget.hostVehicle);

                      // Navigator.push(
                      //   context,
                      //   StaarmPageRoute.routeTo(
                      //     builder: (context) => CarDescription(),
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
