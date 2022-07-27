import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../styles/textstyles.dart';
import '../../../widgets/app_divider.dart';

class ModalWillScope extends StatelessWidget {
  ModalWillScope({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: WillPopScope(
          onWillPop: () async {
            print("Going back");
            return Future.value(false);
            bool shouldClose = true;
            await showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                      title: Text('Should Close?'),
                      actions: <Widget>[
                        CupertinoButton(
                          child: Text('Yes'),
                          onPressed: () {
                            shouldClose = true;
                            Navigator.of(context).pop();
                          },
                        ),
                        CupertinoButton(
                          child: Text('No'),
                          onPressed: () {
                            shouldClose = false;
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ));
            return shouldClose;
          },
          child: Scaffold(
            body: Container(
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

                          Text('Log in or sign up',
                              style: AppTextStyles.cardLabel),
                          Padding(
                            padding: const EdgeInsets.only(right: 14.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}