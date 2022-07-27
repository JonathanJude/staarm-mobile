import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:staarm_mobile/ui/base/base_view.dart';
import 'package:staarm_mobile/utils/app_helper.dart';
import 'package:staarm_mobile/widgets/buttons/app_button.dart';
import 'package:staarm_mobile/widgets/textfields/normal_auth_textfield.dart';

import 'view_model.dart';

class CarDescription extends StatefulWidget {
  final String draftId;
  const CarDescription({Key key, @required this.draftId}) : super(key: key);

  @override
  _CarDescriptionState createState() => _CarDescriptionState();
}

class _CarDescriptionState extends State<CarDescription> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BaseView<CarDescriptionViewModel>(
      model: CarDescriptionViewModel(),
      onModelReady: (model) => model.init(widget.draftId),
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
                      'Description',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    'Let guests know why they would enjoy renting yout vehicle.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 17),
                  NormalAuthTextField(
                    labelText: 'Description',
                    maxLines: 6,
                    controller: model.descTextController,
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
                      model.updateVehicleDesc();
                      
                      // Navigator.push(
                      //   context,
                      //   StaarmPageRoute.routeTo(
                      //     builder: (context) => UploadPhotoInfo(),
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
