
import 'package:flutter/material.dart';
import 'package:staarm_mobile/styles/colors.dart';
import 'package:staarm_mobile/ui/base/base_view.dart';
import 'package:staarm_mobile/utils/app_helper.dart';
import 'package:staarm_mobile/widgets/buttons/app_button.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import 'view_model.dart';

class UploadPhotosView extends StatefulWidget {
  final List<AssetEntity> photos;
  final String draftId;
  const UploadPhotosView({
    Key key,
    @required this.photos,
    @required this.draftId,
  }) : super(key: key);

  @override
  _UploadPhotosViewState createState() => _UploadPhotosViewState();
}

class _UploadPhotosViewState extends State<UploadPhotosView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BaseView<UploadPhotosViewModel>(
      model: UploadPhotosViewModel(),
      onModelReady: (model) => model.init(
        widget.draftId,
        widget.photos,
      ),
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              if (Navigator.of(context).canPop()) {
                AppHelper.cancelVehicleCreation(context);
              }
            },
            icon: Icon(
              Icons.clear,
              color: AppColors.grey5,
            ),
          ),
          backgroundColor: AppColors.appBackground,
          elevation: 0,
          title: Text(
            'Car photos',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ),
        body: SingleChildScrollView(
          controller: model.scrollController,
          child: Column(
            children: [
              model.isLoading
                  ? Container(
                      width: size.width,
                      height: 42,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(0xFF707070),
                      ),
                      child: Text(
                        'Uploading ${model.photos.length} pictures...',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Divider(
                      color: Color(0xFF707070),
                      height: 1,
                    ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 10,
                ),
                child: Column(
                  children: [
                    //cover phooto
                    if (model.photos.length > 0)
                    Container(
                      height: 130,
                      decoration: BoxDecoration(
                        color: Color(0xFFC4C4C4),
                        image: DecorationImage(
                          image: AssetEntityImageProvider(model.photos.first, isOriginal: false),
                          // image: FileImage(
                          //   File(photo.path),
                          // ),
                        ),
                      ),
                    ),

                    SizedBox(height: 10),

                    //grid photos
                    if (model.photos.length > 0)
                      GridView.count(
                        shrinkWrap: true,
                        controller: model.scrollController,
                        crossAxisCount: 2,
                        childAspectRatio: 1.5,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        children: model.photos
                            .map((e) => UploadPhotoItem(photo: e))
                            .toList(),
                      ),
                    SizedBox(height: size.height * .19),
                  ],
                ),
              )
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
            bottom: 25,
            top: 4,
            left: 30,
            right: 30,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppButton(
                color: Colors.black,
                isLoading: model.isLoading,
                onPressed: () {
                  model.updateVehiclePhotos();
                  // Navigator.push(
                  //   context,
                  //   StaarmPageRoute.routeTo(
                  //     builder: (context) => SafetyAndQualityView(),
                  //   ),
                  // );
                },
                text: 'Next',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UploadPhotoItem extends StatelessWidget {
  final AssetEntity photo;
  const UploadPhotoItem({
    Key key,
    @required this.photo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Color(0xFFC4C4C4),
        image: DecorationImage(
          image: AssetEntityImageProvider(photo, isOriginal: false),
          // image: FileImage(
          //   File(photo.path),
          // ),
        ),
      ),
    );
  }
}
