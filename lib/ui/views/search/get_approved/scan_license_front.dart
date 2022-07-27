
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

// List<CameraDescription> cameras;
List<CameraDescription> cameras;


class ScanlicenceFrontView extends StatefulWidget {
  final List<CameraDescription> cameras;

  const ScanlicenceFrontView({Key key, @required this.cameras})
      : super(key: key);

  @override
  _ScanlicenceFrontViewState createState() => _ScanlicenceFrontViewState();
}

class _ScanlicenceFrontViewState extends State<ScanlicenceFrontView> {
  CameraController controller;

  // @override
  // void initState() {
  //   super.initState();

  //   loadCam();

  //   controller = CameraController(cameras[0], ResolutionPreset.max);
  //   controller.initialize().then((_) {
  //     if (!mounted) {
  //       return;
  //     }
  //     setState(() {});
  //   });
  // }

  void onCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) await controller.dispose();
    controller = CameraController(cameraDescription, ResolutionPreset.medium);

    controller.addListener(() {
      if (mounted) setState(() {});
      if (controller.value.hasError) {
        // showMessage('Camera Error: ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      // showException(e);
    }

    if (mounted) setState(() {});
  }

  @override
  void initState() {
    try {
      onCameraSelected(widget.cameras[1]);
    } catch (e) {
      print(e.toString());
    }
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }


  // _onScan() async {
  //   try {
  //     await _initializeControllerFuture;

  //     final path = join(
  //       (await getTemporaryDirectory()).path,
  //       '${DateTime.now()}.png',
  //     );

  //     // await controller.takePicture();
  //     await controller.takePicture(path);
  //     // HXLoader.show(context);
  //     // final rawImage = File(path);

  //     // final file = await MultipartFile.fromPath('file', rawImage.path);

  //     // final result = await ProfileGraphQLService.uploadKycIDImages(
  //     //     {"file": file, "imageType": "PHOTO_PROOF"});
  //     // HXLoader.hide();
  //     // if (result is GraphQLError) {
  //     //   HXFlushBar.error(context: context, message: result.message);
  //     // } else {
  //     //   print('Result: $result');
  //     //   _onSelfieScan();
  //     // }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.white,
        body: CameraPreview(controller),
        
        //  ScanScreen(
        //   controller: controller,
        //   size: size,
        //   isDocumentSideFront: true,
        //   onScan: (){},
        // )
      );

    // return Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: Colors.white,
    //     iconTheme: IconThemeData(
    //       color: Color(0xFF717171),
    //     ),
    //     title: Text(
    //       'Scan licence front',
    //       style: TextStyle(
    //         color: Colors.black,
    //         fontSize: 14,
    //       ),
    //     ),
    //   ),
    //   body: SingleChildScrollView(
    //     child: Padding(
    //       padding: const EdgeInsets.symmetric(
    //         horizontal: 16,
    //         vertical: 17,
    //       ),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Padding(
    //             padding: const EdgeInsets.symmetric(vertical: 6.0),
    //             child: Text(
    //               'Enter the code we’ve sent by Staarm',
    //               style: TextStyle(
    //                 color: Color(0xFF231F20),
    //                 fontSize: 14,
    //                 fontWeight: FontWeight.w400,
    //               ),
    //             ),
    //           ),
    //           SizedBox(height: 20),
    //           NormalAuthTextField(
    //             labelText: 'NIN',
    //           ),

    //           SizedBox(height: 40),
    //         ],
    //       ),
    //     ),
    //   ),
    //   bottomSheet: BottomAppButtonContainer(
    //     child: AppButton(
    //       onPressed: () {
    //         Navigator.push(
    //           context,
    //           StaarmPageRoute.routeTo(
    //             builder: (context) => DriverslicenceGetApproved(),
    //           ),
    //         );
    //       },
    //       text: 'Save & Continue',
    //     ),
    //   ),
    // );
  }
}

class ScanScreen extends StatelessWidget {
  const ScanScreen({
    Key key,
    @required this.controller,
    @required this.size,
    @required this.isDocumentSideFront,
    @required this.onScan,
  }) : super(key: key);

  final CameraController controller;
  final Size size;
  final bool isDocumentSideFront;
  final Function onScan;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * .81,
            child: Center(
              child: Container(
                child: AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: CameraPreview(controller),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              height: controller.value.previewSize.height,
              width: controller.value.previewSize.width,
              decoration: BoxDecoration(
                  // shape: BoxShape.circle,
                  // color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage('assets/images/selfie_overlay.png'),
                      fit: BoxFit.fitWidth)),
            ),
          ),
          Align(alignment: Alignment.topCenter, child: appBar(context)),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: size.height * .23,
              padding: EdgeInsets.symmetric(vertical: 0.0),
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    // height: size.height * .2,
                    // constraints: BoxConstraints.expand(height: 34),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                            'Ensure your face is well lit and has no background lights'),
                        SizedBox(height: 34),
                        // CustomButton(btnText: 'SCAN', isGradient: true, onpress: onScan)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget appBar(BuildContext context) {
  return Column(
    children: <Widget>[
      SizedBox(height: 36),
      Container(
        height: 60.0,
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsets.only(left: 30.0),
                child: Image.asset(
                  'assets/images/dark_back.png',
                  width: 53,
                ),
              ),
            ),
            // Spacer(
            //   flex: 1,
            // ),
            // Text(
            //   'Scan Document',
            //   style: TextStyle(
            //       fontSize: 17,
            //       color: Colors.white,
            //       fontWeight: FontWeight.w600),
            // ),
            // Spacer(
            //   flex: 2,
            // ),
            // Container(),
          ],
        ),
      ),
    ],
  );
}
