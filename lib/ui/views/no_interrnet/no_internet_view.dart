import 'package:flutter/material.dart';

import '../../../../../styles/colors.dart';
import '../../../utils/dimensions.dart';
import '../../base/base_view.dart';
import 'view_model.dart';

class NoInternetView extends StatelessWidget {
  final Function onTryAgain;

  const NoInternetView({Key key, @required this.onTryAgain}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final scaler = AppScaleUtil(context);
    return BaseView<NoInternetViewModel>(
      model: NoInternetViewModel(),
      builder: (context, model, _) => Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.symmetric(
                    vertical: size.height * .07,
                    horizontal: 22,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        'assets/images/raster/splash_internet_slow.png',
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Ooops!',
                          style:
                              TextStyle(fontSize: 20, color: Color(0xFF8F8FAC)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text(
                        'Your internet may be slow or your device is not connected to the internet, check your internet connection.',
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      Container(
                        height: 1,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.grey.withOpacity(.6),
                      ),
                      SizedBox(height: 16),
                      // AppSolidButton(
                      //   text: 'TRY AGAIN',
                      //   height: 50,
                      //   style: TextStyle(
                      //     fontSize: 14,
                      //     color: Colors.white,
                      //     fontWeight: FontWeight.w700,
                      //   ),
                      //   onPressed: onTryAgain,
                      // ),
                    ],
                  ),
                ),
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
