import 'package:flutter/material.dart';

import '../../styles/colors.dart';
import '../../styles/textstyles.dart';
import '../dialogs/app_button_spinner.dart';
import 'app_button_helpers.dart';

class AppButton extends StatelessWidget {
  final Function() onPressed;
  final Color color;
  final Color textColor;
  final String text;
  final bool disabled;
  final bool isLoading;
  final IconData icon;
  final double borderRadius;
  final AppButtonType type;
  final bool isExpanded;
  final AppButtonIconPosition iconPosition;
  final Color disabledColor;
  final Color disabledTextColor;
  final double textFontSize;

  const AppButton({
    Key key,
    @required this.text,
    @required this.onPressed,
    this.disabled = false,
    this.isLoading = false,
    this.isExpanded = true,
    this.color = AppColors.primaryColor,
    this.textColor = Colors.white,
    this.icon,
    this.borderRadius = 6.0,
    this.type = AppButtonType.Small,
    this.iconPosition = AppButtonIconPosition.leading,
    this.disabledColor = const Color(0xFFBDBDC8),
    this.disabledTextColor = Colors.white,
    this.textFontSize = 16.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDisabled = onPressed == null || disabled;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: ElevatedButton(
        onPressed: isDisabled || isLoading ? null : onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              isDisabled ? const Color(0xFFBDBDC8) : color),
          padding: MaterialStateProperty.all<EdgeInsets>(
            EdgeInsets.symmetric(
              vertical: AppButtonHelpers.verticalPadding(type),
              horizontal: AppButtonHelpers.horizontalPadding(type),
            ),
          ),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: type == AppButtonType.FulllWdith || isExpanded
              ? MainAxisSize.max
              : MainAxisSize.min,
          children: [
            if (isLoading)
              AppButtonSpinner(color: textColor)
            else
              Row(
                children: [
                  if (icon != null &&
                      iconPosition == AppButtonIconPosition.leading)
                    Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(
                        icon,
                        color: isDisabled ? disabledColor : textColor,
                      ),
                    ),
                  Text(
                    text ?? '',
                    style: AppTextStyles.cta.copyWith(
                      color: textColor
                    ),
                  ),
                  if (icon != null &&
                      iconPosition == AppButtonIconPosition.trailing)
                    Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(
                        icon,
                        color: isDisabled ? disabledColor : textColor,
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
