import 'package:flutter/material.dart';
import 'package:staarm_mobile/styles/colors.dart';
import 'package:staarm_mobile/ui/base/base_view.dart';
import 'package:staarm_mobile/utils/app_helper.dart';

import 'view_model.dart';

class UploadPhotoInfo extends StatefulWidget {
  final String draftId;
  const UploadPhotoInfo({Key key, @required this.draftId}) : super(key: key);

  @override
  _UploadPhotoInfoState createState() => _UploadPhotoInfoState();
}

class _UploadPhotoInfoState extends State<UploadPhotoInfo> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BaseView<UploadPhotoInfoViewModel>(
      model: UploadPhotoInfoViewModel(),
      onModelReady: (model) => model.init(widget.draftId),
      builder: (context, model, _) => Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'assets/images/host_vehicle_2.png',
                height: size.height * .4,
                width: size.width,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: size.height * .35,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 14,
                  ),
                  width: size.width,
                  constraints: BoxConstraints(
                    minHeight: size.height * .4,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                        ),
                        child: Text(
                          'Let’s add some pictures of your car',
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
                          'Here are some tips to help you take pictures that make your listing stand out.',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          CarUploadPhotoInfoTip(
                            text: 'Shoot during the daytime',
                          ),
                          SizedBox(width: 25),
                          CarUploadPhotoInfoTip(
                            text: 'Take clear, crisp pictures',
                          ),
                        ],
                      ),
                      SizedBox(height: 14),
                      Row(
                        children: [
                          CarUploadPhotoInfoTip(
                            text: 'Try somewhere open or scenic',
                          ),
                          SizedBox(width: 25),
                          CarUploadPhotoInfoTip(
                            text: 'Watch out for moving cars',
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      GestureDetector(
                        onTap: () {
                          model.pickImageAssets();
                          // model.pickImages(); //TODO replace back

                          // if(_imageFileList != null && _imageFileList.length > 0){
                          //   Navigator.push(
                          //   context,
                          //   StaarmPageRoute.routeTo(
                          //     builder: (context) => UploadPhotosView(
                          //       photos: _imageFileList,
                          //     ),
                          //   ),
                          // );
                          // }
                        },
                        child: Center(
                          child: Text(
                            'Upload from gallery',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),

                      if (model.isLoading)
                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            child: Text('Processing..'),
                          ),
                        ),

                      SizedBox(height: 30),
                      // AppButton(
                      //   text: 'Take new pictures',
                      //   onPressed: () {
                      //     // Navigator.push(
                      //     //   context,
                      //     //   StaarmPageRoute.routeTo(
                      //     //     builder: (context) => SelectCar1View(),
                      //     //   ),
                      //     // );
                      //   },
                      //   color: Color(0xFF231F20),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 40,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  if (Navigator.of(context).canPop()) {
                    AppHelper.cancelVehicleCreation(context);
                  }
                },
                child: Icon(
                  Icons.cancel,
                  size: 40,
                  color: AppColors.grey2.withOpacity(.4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CarUploadPhotoInfoTip extends StatelessWidget {
  final String text;
  const CarUploadPhotoInfoTip({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Color(0xFFC4C4C4),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
            ),
            child: Text(
              text ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
