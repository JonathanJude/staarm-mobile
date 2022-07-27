import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../styles/textstyles.dart';
import 'app_divider.dart';

class AppDialog extends StatelessWidget {
  final Function onClose;
  final String title;
  final Widget child;
  final Widget bottomChild;
  AppDialog({
    Key key,
    @required this.title,
    this.onClose,
    @required this.child,
    this.bottomChild,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: WillPopScope(
        onWillPop: () async {
          bool shouldClose = true;
          if (onClose != null) {
            await onClose();
          }
          return shouldClose;
        },
        child: Scaffold(
          body: Stack(
            children: [
              SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.only(top: 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 16),
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF202046).withOpacity(.08),
                          blurRadius: 8,
                          spreadRadius: 0,
                          offset: Offset(0, -6),
                        ),
                      ],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 5,
                          width: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Color(0xFFDDDDDD),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 25,
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 14.0),
                              //   child: GestureDetector(
                              //     onTap: () {
                              //       Navigator.of(context).pop();
                              //     },
                              //     child: Icon(Icons.arrow_back_ios,
                              //         color: Color(0xFF717171), size: 22),
                              //   ),
                              // ),

                              Text(
                                title ?? '',
                                style: AppTextStyles.cardLabel,
                              ),

                              Padding(
                                padding: const EdgeInsets.only(right: 14.0),
                                child: GestureDetector(
                                  onTap: () {
                                    if (onClose != null) {
                                      onClose();
                                    } else {
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  child: Icon(Icons.clear,
                                      color: Colors.black, size: 25),
                                ),
                              ),
                            ],
                          ),
                        ),
                        AppDivider(
                          color: Color(0xFFE7E7E8),
                        ),
                        SizedBox(height: 7),

                        //child

                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 16,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              child,
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0 ,
                right: 0,
                left: 0,
                child: bottomChild != null ? bottomChild : SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Positioned(
//                   bottom: 20,
//                                   child: Container(
//             padding: EdgeInsets.symmetric(
//               vertical: 12,
//               horizontal: 14,
//             ),
//             child: Row(
//               children: [
//                   Text(
//                     'Reset',
//                     style: TextStyle(
//                         decoration: TextDecoration.underline,
//                         color: Colors.black),
//                   )
//               ],
//             ),
//           ),
//                 ),
