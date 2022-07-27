import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:staarm_mobile/widgets/hide_keyboard_on_tap.dart';

import '../styles/colors.dart';
import '../widgets/app_dialog.dart';
import '../widgets/small_app_dialog.dart';

class StaarmModalHelpers {
  StaarmModalHelpers._();

  static Future<T> fullpageModal<T>(
    BuildContext context, {
    @required Widget child,
    Widget bottomChild,
    String title,
    bool displayBackButton = false,
    bool shouldPop = true,
    Color cancelButtonColor = AppColors.primaryColor,
    Color backgroundColor = Colors.white,
    Function onCancel,
  }) async {
    return showCupertinoModalBottomSheet(
      expand: true,
      context: context,
      isDismissible: false,
      useRootNavigator: true,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context) => HideKeyboardOnTap(
              child: AppDialog(
          title: title,
          child: child,
          bottomChild: bottomChild,
        ),
      ),
    );
  }


  static Future<T> normalModal<T>(
    BuildContext context, {
    @required Widget child,
    String title,
    bool displayBackButton = false,
    bool shouldPop = true,
    Color cancelButtonColor = AppColors.primaryColor,
    Color backgroundColor = Colors.white,
    Function onCancel,
  }) async {
    return showCupertinoModalBottomSheet(
      expand: false,
      context: context,
      isDismissible: false,
      useRootNavigator: true,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context) => SmallAppDialog(
        title: title,
        child: child,
      ),
    );
  }

  // static Future<T> materialBottomSheet<T>(
  //   BuildContext context, {
  //   @required Widget child,
  //   List<Widget> actions,
  //   String title,
  //   Color cancelButtonColor = AppColors.primaryColor,
  //   Color backgroundColor = Colors.white,
  //   Function onCancel,
  // }) async {
  //   return showCupertinoModalBottomSheet<T>(
  //     expand: false,
  //     topRadius: Radius.circular(12),
  //     context: context,
  //     backgroundColor: Colors.transparent,
  //     builder: (context) => Padding(
  //       padding: EdgeInsets.only(
  //         bottom: MediaQuery.of(context).viewInsets.bottom,
  //       ),
  //       child: _StaarmMaterialBottomSheet(
  //         child: child,
  //         backgroundColor: backgroundColor,
  //         cancelButtonColor: cancelButtonColor,
  //         onCancel: onCancel,
  //         title: title,
  //         actions: actions,
  //       ),
  //     ),
  //   );
  // }
}

class _StaarmMaterialBottomSheet extends StatelessWidget {
  final Widget child;
  final String title;
  final Color cancelButtonColor;
  final Function onCancel;
  final Color backgroundColor;
  final List<Widget> actions;

  const _StaarmMaterialBottomSheet({
    Key key,
    this.title,
    this.onCancel,
    this.cancelButtonColor = AppColors.primaryColor,
    this.backgroundColor = Colors.white,
    this.child,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 19.0),
          shrinkWrap: true,
          controller: ModalScrollController.of(context),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 21.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  if (title != null)
                    Text(
                      title ?? '',
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  Spacer(),

                  //action widgets
                  if (actions != null) ...actions,

                  GestureDetector(
                    onTap: () {
                      if (onCancel != null) {
                        onCancel();
                      }
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 13),
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: cancelButtonColor.withOpacity(.1),
                      ),
                      child: Icon(
                        Icons.clear,
                        color: cancelButtonColor,
                        size: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}

class _StaarmModalWithNavigator extends StatelessWidget {
  final Widget child;
  final String title;
  final bool displayBackButton;
  final bool shouldPop;
  final Color cancelButtonColor;
  final Function onCancel;
  final Color backgroundColor;

  _StaarmModalWithNavigator({
    Key key,
    @required this.child,
    this.title,
    this.displayBackButton = false,
    this.shouldPop = true,
    this.cancelButtonColor = AppColors.primaryColor,
    this.backgroundColor = Colors.white,
    this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext rootContext) {
    return Material(
      color: backgroundColor,
      child: WillPopScope(
        onWillPop: () async {
          if (onCancel != null) {
            await onCancel();
          }
          return shouldPop;
        },
        child: Builder(
          builder: (context) => SafeArea(
            bottom: false,
            child: ListView(
              shrinkWrap: false,
              padding: EdgeInsets.symmetric(horizontal: 24),
              controller: ModalScrollController.of(context),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 21.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if (displayBackButton)
                        Padding(
                          padding: const EdgeInsets.only(right: 13.0),
                          child: GestureDetector(
                            child: Icon(
                              Icons.arrow_back,
                              size: 22,
                              color: AppColors.primaryColor,
                            ),
                            onTap: () {
                              Navigator.of(rootContext).pop();
                            },
                          ),
                        ),
                      if (title != null)
                        Text(
                          title ?? '',
                          style: TextStyle(
                            fontSize: 20,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          if (onCancel != null) {
                            onCancel();
                          }
                          Navigator.of(rootContext).pop();
                        },
                        child: Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: cancelButtonColor.withOpacity(.1),
                          ),
                          child: Icon(
                            Icons.clear,
                            color: cancelButtonColor,
                            size: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
