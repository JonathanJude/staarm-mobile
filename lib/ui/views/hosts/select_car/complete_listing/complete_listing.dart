import 'package:flutter/material.dart';
import 'package:staarm_mobile/styles/colors.dart';
import 'package:staarm_mobile/ui/base/base_view.dart';
import 'package:staarm_mobile/widgets/buttons/app_button.dart';

import 'view_model.dart';

class CompleteListingView extends StatelessWidget {
  final String draftId;
  const CompleteListingView({Key key, @required this.draftId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<CompleteListingViewModel>(
      model: CompleteListingViewModel(),
      onModelReady: (model) => model.init(draftId),
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: AppColors.grey5,
            ),
          ),
          backgroundColor: AppColors.appBackground,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Center(
                child: Image.asset(
                  'assets/images/bell_icon.png',
                  height: 100,
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                ),
                child: Text(
                  'Submit your listing',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                ),
                child: Text(
                  'You’re ready to list your car on Staarm. You’ll be able to edit your listing, pricing, and availability anytime.',
                  style: TextStyle(
                    color: AppColors.grey5,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Padding(
              //   padding: const EdgeInsets.symmetric(
              //     vertical: 14,
              //   ),
              //   child: Row(
              //     children: [
              //       Checkbox(
              //         value: true,
              //         onChanged: (val) {},
              //         activeColor: AppColors.mainPurple,
              //       ),
              //       Flexible(
              //         child: Text(
              //           'You’re ready to list your car on Staarm. You’ll be able to edit your listing, pricing, and availability anytime.',
              //           style: TextStyle(
              //             color: AppColors.grey5,
              //             fontSize: 14,
              //             fontWeight: FontWeight.w400,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
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
            bottom: 30,
            top: 4,
            left: 30,
            right: 30,
          ),
          child: Row(
            children: [
              Flexible(
                child: AppButton(
                  color: Color(0xFF824DFF),
                  isLoading: model.isLoading,
                  onPressed: () {
                    model.completeVehicleCreation();
                    // Navigator.push(
                    //   context,
                    //   StaarmPageRoute.routeTo(
                    //     builder: (context) => CarFeatures(),
                    //   ),
                    // );
                  },
                  text: 'Submit',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
