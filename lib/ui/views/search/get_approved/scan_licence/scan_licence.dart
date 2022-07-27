import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:staarm_mobile/styles/colors.dart';
import 'package:staarm_mobile/ui/base/base_view.dart';
import 'package:staarm_mobile/ui/views/search/widgets/shutter_button.dart';
import 'package:staarm_mobile/widgets/buttons/app_button.dart';
import 'package:staarm_mobile/widgets/buttons/outline_button.dart';

import 'view_model.dart';

List<CameraDescription> cameras;

class KYCScanLicence extends StatefulWidget {
  final List<CameraDescription> cameras;
  final String driversLicenceVerificationId;
  const KYCScanLicence({
    Key key,
    @required this.cameras,
    @required this.driversLicenceVerificationId,
  }) : super(key: key);

  @override
  _KYCScanLicenceState createState() => _KYCScanLicenceState();
}

class _KYCScanLicenceState extends State<KYCScanLicence> {
  // @override
  // void initState() {
  //   super.initState();
  //   loadCam();
  // }

  // loadCam() async {
  //   try {
  //     cameras = await availableCameras();
  //   } on CameraException catch (e) {
  //     //logError(e.code, e.description);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BaseView<KYCScanLicenceModel>(
      model: KYCScanLicenceModel(),
      onModelReady: (model) => model.init(widget.cameras),
      onDispose: (model) => model.dispose(),
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Color(0xFF717171),
          ),
          title: Text(
            "Scan licence front",
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ),
        body: (widget.cameras.length == 0)
            ? Center(
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'No Camera Found',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            : (!model.cameraController.value.isInitialized)
                ? Container()
                : Container(
                    // height: size.height,
                    child: Stack(children: [
                      //camera preview
                      Container(
                        child: Center(
                          child: Container(
                            // decoration: (!model.isOnCaptureMode &&
                            //         (model.frontLicence != null ||
                            //             model.backLicence != null))
                            //     ? BoxDecoration(
                            //         // color: Colors.green,
                            //         image: DecorationImage(
                            //           image: FileImage(
                            //             File(model.isFront
                            //                 ? model.frontLicence.path
                            //                 : model.backLicence.path),
                            //           ),
                            //         ),
                            //       )
                            //     : BoxDecoration(color: Colors.red),
                            child: model.isOnCaptureMode
                                ? CameraPreview(model.cameraController)
                                : Container(
                                    height: size.height,
                                    width: size.width,
                                    child: Image.file(
                                      File(
                                        model.isFront
                                            ? model.frontLicence.path
                                            : model.backLicence.path,
                                      ),
                                      height: size.height,
                                      width: size.width,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                          ),
                        ),
                      ),

                      Positioned.fill(
                        child: Container(
                          height:
                              model.cameraController.value.previewSize.height,
                          width: model.cameraController.value.previewSize.width,
                          child: Opacity(
                            opacity: 1,
                            child: Container(
                              height: size.height,
                              width: size.width,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: size.height * .03,
                                  ),
                                  Container(
                                    width: size.width * .75,
                                    height: size.height * .55,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 4,
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),

                                  //text
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                    ),
                                    child: Text(
                                      model.isOnCaptureMode
                                          ? 'Fit the ${model.isFront ? 'front' : 'back'} of the licence \nwithin the frame.'
                                          : 'Make sure it is well-lit, clear and nothing is cut off.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),

                                  Spacer(),

                                  //shutter button

                                  if (model.isOnCaptureMode)
                                    ShuttterButton(
                                      onTap: () {
                                        model.onCapture();
                                      },
                                    ),

                                  if (!model.isOnCaptureMode)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 18,
                                      ),
                                      child: AppButton(
                                        text: 'Submit photo',
                                        isLoading: model.isLoading,
                                        onPressed: () {
                                          model.onSubmitPhoto(widget
                                              .driversLicenceVerificationId);
                                        },
                                        color: Colors.white,
                                        textColor: AppColors.mainBlack,
                                      ),
                                    ),

                                  if (!model.isOnCaptureMode || !model.isLoading)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 18,
                                      ),
                                      child: AppOutlineButton(
                                        title: 'Retake photo',
                                        onTap: () {
                                          model.onRetakePhoto();
                                        },
                                      ),
                                    ),

                                  SizedBox(height: 24),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
      ),
    );
  }
}
