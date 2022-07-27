import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staarm_mobile/core/models/vehicle/vehicle_model.dart';
import 'package:staarm_mobile/core/providers/vehicle_provider.dart';
import 'package:staarm_mobile/ui/base/base_view.dart';
import 'package:staarm_mobile/ui/views/search/checkout/checkout_view.dart';
import 'package:staarm_mobile/utils/staarm_page_route.dart';
import 'package:staarm_mobile/widgets/buttons/app_button.dart';
import 'package:staarm_mobile/widgets/buttons/bottom_app_button_container.dart';
import 'package:staarm_mobile/widgets/indicators/staarm_loader.dart';

import 'view_model.dart';
import 'widgets/protection_plan_item.dart';

class SelectProtectionPlanView extends StatelessWidget {
  final VehicleModel vehicle;
  final DateTime tripStartDate;
  final DateTime tripEndDate;
  const SelectProtectionPlanView({
    Key key,
    @required this.vehicle,
    @required this.tripStartDate,
    @required this.tripEndDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<SelectProtectionPlanViewModel>(
      model: SelectProtectionPlanViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Color(0xFF717171),
          ),
          title: Text(
            'Protection plans',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 17,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  child: Text(
                    'Choose a protection plan that includes coverage under a policy of insurance from Smoke Assurance offered through Staarm.',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF717171),
                    ),
                  ),
                ),
                Consumer<VehicleProvider>(
                  builder: (context, vehicleProvider, _) =>
                      vehicleProvider.isSyncingProtectionPlan
                          ? Center(child: StaarmSpinner())
                          : vehicleProvider.protectionPlans.length == 0
                              ? Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 20,
                                    ),
                                    child: Text('No Protection Plan available'),
                                  ),
                                )
                              : Column(
                                  children: vehicleProvider.protectionPlans
                                      .map(
                                        (plan) => ProtectionPlanItem(
                                          plan: plan,
                                          selected: model.selectedPlan == plan,
                                          onSelect: (v) {
                                            model.selectedPlan = v;
                                          },
                                        ),
                                      )
                                      .toList(),
                                ),
                ),
              ],
            ),
          ),
        ),
        bottomSheet: BottomAppButtonContainer(
          child: AppButton(
            // isLoading: model.isLoading,
            disabled: model.selectedPlan == null,
            onPressed: () {
              // Navigator.pop(context, model.selectedPlan);

              Navigator.push(
                context,
                StaarmPageRoute.routeTo(
                  builder: (context) => CheckoutView(
                    vehicle: vehicle,
                    tripStartDate: tripStartDate,
                    tripEndDate: tripEndDate,
                    protectionPlan: model.selectedPlan,
                  ),
                ),
              );
            },
            text: 'Next',
          ),
        ),
      ),
    );
  }
}
