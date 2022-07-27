import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

import '../styles/colors.dart';

class StaarmToast {
  static success({@required String message}) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: AppColors.primaryColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check, color: Colors.white),
          SizedBox(
            width: 12.0,
          ),
          Text(
            message ?? '',
            style: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );

    showToastWidget(
      toast,
      position: ToastPosition.bottom,
      duration: Duration(seconds: 2),
    );
  }

  //success & undo
  static successAndUndo(
      {@required String message, @required Function undoPressed}) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: AppColors.primaryColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check, color: Color(0xFF6CEBBD)),
          SizedBox(
            width: 12.0,
          ),
          Text(
            message ?? '',
            style: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            width: 12.0,
          ),
          GestureDetector(
            onTap: undoPressed,
            child: Text(
              'Undo',
              style: TextStyle(
                  color: Color(0xFF9D98F9),
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );

    showToastWidget(
      toast,
      position: ToastPosition.bottom,
      duration: Duration(seconds: 2),
    );
  }
}
