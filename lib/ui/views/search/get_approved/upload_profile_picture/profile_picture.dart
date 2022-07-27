import 'dart:io';

import 'package:flutter/material.dart';
import 'package:staarm_mobile/ui/base/base_view.dart';
import 'package:staarm_mobile/widgets/buttons/app_button.dart';
import 'package:staarm_mobile/widgets/buttons/bottom_app_button_container.dart';

import 'view_model.dart';

class UploadKYCProfilePictureView extends StatelessWidget {
  const UploadKYCProfilePictureView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<UploadKYCProfilePictureViewModel>(
      model: UploadKYCProfilePictureViewModel(),
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Color(0xFF717171),
          ),
          title: Text(
            'Profile picture',
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
                    'Please provide a clear photo of your face so your host can recognize you.',
                    style: TextStyle(
                      color: Color(0xFF231F20),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: (){
                    model.addPhoto();
                  },
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Color(0xFFF4F5F6),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Color(0xFF824DFF),
                              width: 4,
                            ),
                            image: model.imageFile == null
                                ? null
                                : DecorationImage(
                                    image: FileImage(
                                      File(model.imageFile.path),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 9.0),
                          child: Text(
                            model.imageFile == null ? 'Add a photo' : 'Change photo',
                            style: TextStyle(
                              color: Color(0xFF824DFF),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
        bottomSheet: BottomAppButtonContainer(
          child: AppButton(
            disabled: model.imageFile == null,
            isLoading: model.isLoading,
            onPressed: () {
              model.uploadPhoto();

              // Navigator.push(
              //   context,
              //   StaarmPageRoute.routeTo(
              //     builder: (context) => KYCNinView(),
              //   ),
              // );
            },
            text: 'Save & Continue',
          ),
        ),
      ),
    );
  }
}
