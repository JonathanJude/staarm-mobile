
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../styles/colors.dart';
import '../../../utils/dimensions.dart';
import '../../../values/images.dart';
import '../../base/base_view.dart';
import 'app_startup_view_model.dart';

class SplashPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final scaler = AppScaleUtil(context);
    return BaseView<AppStartupViewModel>(
      model: AppStartupViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, _) => Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                Image.asset(
                  AppImages.staarmLogo,
                  height: 120,
                  width: 140,
                ),
                Spacer(),
                if (model.isChecking)
                  SpinKitThreeBounce(
                    color: Colors.white,
                    size: 25.0,
                  ),
                SizedBox(height: size.height * .08)
              ],
            ),
          ),
          padding: scaler.insets.symmetric(
            horizontal: 5,
          ),
        ),
      ),
    );
  }
}
