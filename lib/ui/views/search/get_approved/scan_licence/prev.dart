// import 'dart:io';

// import 'package:HaggleX/components/transitions/hagglex_page_route.dart';
// import 'package:HaggleX/core/services/graphql/profile.dart';
// import 'package:HaggleX/ui/views/account/kyc/kyc_selfie.dart';
// import 'package:HaggleX/utils/hx_flush_bar.dart';
// import 'package:HaggleX/utils/hx_loader.dart';
// import 'package:HaggleX/widgets/custom_button.dart';
// import 'package:HaggleX/widgets/dialogs.dart';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'package:path/path.dart' show join;
// import 'package:path_provider/path_provider.dart';

// class KYCScanLicence extends StatefulWidget {
//   final List<CameraDescription> cameras;

//   const KYCScanLicence({Key key, @required this.cameras}) : super(key: key);

//   @override
//   _KYCScanLicenceState createState() => _KYCScanLicenceState();
// }

// class _KYCScanLicenceState extends State<KYCScanLicence> {
//   CameraController controller;
//   Future<void> _initializeControllerFuture;
//   bool _isDocumentSideFront = true;

//   _changeDocumentSide() {
//     CustomDialogs.success(context, MediaQuery
//         .of(context)
//         .size, afterScreen: () {
//       Navigator.pop(context);
//       if (!_isDocumentSideFront) {
//         Navigator.of(context).push(HaggleXPageRoute(builder: (BuildContext context) => KYCSelfieScreen()));
//       } else {
//         setState(() {
//           _isDocumentSideFront = false;
//         });
//       }
//     });
//   }

//   void onCameraSelected(CameraDescription cameraDescription) async {
//     if (controller != null) await controller.dispose();
//     controller = CameraController(cameraDescription, ResolutionPreset.medium);

//     controller.addListener(() {
//       if (mounted) setState(() {});
//       if (controller.value.hasError) {
//         // showMessage('Camera Error: ${controller.value.errorDescription}');
//       }
//     });

//     try {
//       await controller.initialize();
//     } on CameraException catch (e) {
//       // showException(e);
//     }

//     if (mounted) setState(() {});
//   }


//   @override
//   void initState() {
//     try {
//       onCameraSelected(widget.cameras[0]);
//     } catch (e) {
//       print(e.toString());
//     }
//     super.initState();
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }

//   _onScan() async {
//     try {
//       await _initializeControllerFuture;

//       final path = join(
//         (await getTemporaryDirectory()).path,
//         '${DateTime.now()}.png',
//       );

//       await controller.takePicture(path);
//       HXLoader.show(context);
//       final rawImage = File(path);

//       final file = await MultipartFile.fromPath('file', rawImage.path);

//       final result =
//       await ProfileGraphQLService.uploadKycIDImages(
//           {"file": file, "imageType": _isDocumentSideFront ? "FRONT" : "BACK"});
//       HXLoader.hide();
//       if (result is GraphQLError) {
//         HXFlushBar.error(context: context, message: result.message);
//       } else {
//         print('Result: $result');
//         _changeDocumentSide();
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     if (widget.cameras.isEmpty) {
//       return Container(
//         alignment: Alignment.center,
//         padding: EdgeInsets.all(16.0),
//         child: Text(
//           'No Camera Found',
//           style: TextStyle(
//             fontSize: 16.0,
//             color: Colors.white,
//           ),
//         ),
//       );
//     }

//     if (!controller.value.isInitialized) {
//       return Container(
//       );
//     }

//     return Scaffold(
//         backgroundColor: Colors.white,
//         body: ScanScreen(
//           controller: controller,
//           size: size,
//           isDocumentSideFront: _isDocumentSideFront,
//           onScan: _onScan,
//         )
//     );
//   }
// }

// class ScanScreen extends StatelessWidget {
//   const ScanScreen({
//     Key key,
//     @required this.controller, @required this.size, @required this.isDocumentSideFront, @required this.onScan,
//   }) : super(key: key);

//   final CameraController controller;
//   final Size size;
//   final bool isDocumentSideFront;
//   final Function onScan;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Stack(
//         children: <Widget>[
//           Container(
//             height: MediaQuery.of(context).size.height * .81,
//             child: Center(
//               child: Container(
//                 child: AspectRatio(
//                   aspectRatio: controller.value.aspectRatio,
//                   child: CameraPreview(controller),
//                 ),
//               ),
//             ),
//           ),
//           Positioned.fill(
//             child: Container(
//               height: controller.value.previewSize.height,
//               width: controller.value.previewSize.width,
//               decoration: BoxDecoration(
//                 // color: Colors.white,
//                 image: DecorationImage(image: AssetImage("assets/images/id_overlay.png"), fit: BoxFit.fitWidth),
//               ),
//             ),
//           ),
//           Positioned(
//             top: size.height * .22,
//             right: size.width * .4,
//             left: size.width * .4,
//             child: Center(
//                 child: Text(isDocumentSideFront ? 'FRONT' : 'BACK',
//                     style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))),
//           ),
//           Align(alignment: Alignment.topCenter, child: appBar(context)),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               width: double.infinity,
//               height: size.height * .23,
//               padding: EdgeInsets.symmetric(vertical: 0.0),
//               // color: Color.fromRGBO(00, 00, 00, 0.7),
//               child: Stack(
//                 children: <Widget>[
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 25),
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(30),
//                             topRight: Radius.circular(30)
//                         )
//                     ),
//                     // height: size.height * .2,
//                     // constraints: BoxConstraints.expand(height: 34),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: <Widget>[
//                         Text(isDocumentSideFront
//                             ? 'Place your ID within the image frame'
//                             : 'Place the reverse side of your ID within the image frame'),
//                         SizedBox(height: 34),
//                         CustomButton(
//                             btnText: 'SCAN',
//                             isGradient: true,
//                             onpress: onScan
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// Widget appBar(BuildContext context){
//   return Column(
//     children: <Widget>[
//       SizedBox(height: 36),
//       Container(
//         height: 60.0,
//         color: Colors.transparent,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             GestureDetector(
//               onTap: () {
//                 Navigator.pop(context);
//               },
//               child: Padding(
//                 padding: EdgeInsets.only(left: 30.0),
//                 child: Image.asset(
//                   'assets/images/dark_back.png',
//                   width: 53,
//                 ),
//               ),
//             ),
//             Spacer(
//               flex: 1,
//             ),
//             Text(
//               'Scan Document',
//               style: TextStyle(
//                   fontSize: 17,
//                   color: Colors.white,
//                   fontWeight: FontWeight.w600),
//             ),
//             Spacer(
//               flex: 2,
//             ),
//             Container(),
//           ],
//         ),
//       ),
//     ],
//   );
// }