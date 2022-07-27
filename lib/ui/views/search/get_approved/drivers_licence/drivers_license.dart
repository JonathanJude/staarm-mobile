import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:staarm_mobile/ui/base/base_view.dart';
import 'package:staarm_mobile/widgets/app_divider.dart';
import 'package:staarm_mobile/widgets/buttons/app_button.dart';
import 'package:staarm_mobile/widgets/buttons/auth_dob_button.dart';
import 'package:staarm_mobile/widgets/buttons/bottom_app_button_container.dart';
import 'package:staarm_mobile/widgets/textfields/normal_auth_textfield.dart';

import 'view_model.dart';

List<CameraDescription> cameras;

class KYCDriverslicenceView extends StatefulWidget {
  const KYCDriverslicenceView({Key key}) : super(key: key);

  @override
  _KYCDriverslicenceViewState createState() => _KYCDriverslicenceViewState();
}

class _KYCDriverslicenceViewState extends State<KYCDriverslicenceView> {
  @override
  void initState() {
    super.initState();
    loadCam();
  }

  loadCam() async {
    try {
      cameras = await availableCameras();
    } on CameraException {
      //logError(e.code, e.description);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<KYCDriverslicenceViewModel>(
      model: KYCDriverslicenceViewModel(),
      onModelReady: (model) => model.init(),
      builder: (contextt, model, _) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Color(0xFF717171),
          ),
          title: Text(
            "Driver’s licence",
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
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Text(
                    'Enter your information as it appears on your licence so Staarm can verify your eligibity to drive.',
                    style: TextStyle(
                      color: Color(0xFF231F20),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                AppDivider(
                  thickness: .8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: Color(0xFFF4F5F6),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(
                        'Scan licence',
                        style: TextStyle(
                          color: Color(0xFF231F20),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                AppDivider(
                  thickness: .8,
                ),
                SizedBox(height: 10),
                // Text(
                //   'Driver Information',
                //   style: TextStyle(
                //     color: Color(0xFF231F20),
                //     fontSize: 14,
                //     fontWeight: FontWeight.w400,
                //   ),
                // ),
               
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: Text(
                    'licence Information',
                    style: TextStyle(
                      color: Color(0xFF231F20),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                NormalAuthTextField(
                  labelText: 'licence number',
                  onChanged: (str){
                    model.licenceNumber = str;
                  },
                ),

                AuthDOBButton(
                    text: model.formattedDOB,
                    onTap: model.showDatePicker,
                  ),

               
                AppDivider(
                  thickness: .8,
                ),
                SizedBox(height: 4),
                Text(
                  'By continuing you agree that Staarm may collect your auto insurance score.',
                  style: TextStyle(
                    color: Color(0xFF717171),
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
        bottomSheet: BottomAppButtonContainer(
          child: AppButton(
            isLoading: model.isLoading,
            onPressed: () {
              // Navigator.push(
              //   context,
              //   StaarmPageRoute.routeTo(
              //     builder: (context) => KYCScanLicence(
              //       cameras: cameras,
              //       driversLicenceVerificationId: 'ju',
              //     ),
              //   ),
              // );
              model.storeLicenceInfo(cameras);
            },
            text: 'Save & Continue',
          ),
        ),
      ),
    );
  }
}
