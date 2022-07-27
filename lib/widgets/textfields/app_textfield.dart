import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../styles/colors.dart';


class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String initialValue;
  final String labelText;
  final String hintText;
  final TextInputType keyboardType;
  final FocusNode focusNode;
  final Color borderColor;
  final String Function(String) validator;
  final Function(String) onSaved;
  final Function(String) onChanged;
  final bool digitsOnly;
  final bool isDisabled;
  final bool isAmount;
  final bool isEnabled;
  final int maxLines;
  final Widget suffix;

  const AppTextField({
    Key key,
    this.controller,
    this.labelText,
    this.hintText,
    this.initialValue,
    this.borderColor = AppColors.primaryColor,
    this.keyboardType,
    this.focusNode,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.digitsOnly = false,
    this.isDisabled = false,
    this.isAmount = false,
    this.isEnabled = true,
    this.maxLines,
    this.suffix,
  }) : super(key: key);

  OutlineInputBorder textFieldBorder([bool isFocused = false]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(
        color: isFocused ? borderColor : AppColors.primaryColor.withOpacity(.1),
        width: 1.4,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (labelText != null)
            Text(
              labelText ?? '',
              style: TextStyle(
                  color: AppColors.primaryColor.withOpacity(.8),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto'),
            ),
          if (labelText != null) SizedBox(height: 10),
          SizedBox(
            // height: 55,
            child: TextFormField(
              initialValue: initialValue,
              focusNode: focusNode,
              controller: controller,
              validator: validator,
              onSaved: onSaved,
              onChanged: onChanged,
              enabled: isEnabled,
              maxLines: maxLines,
              
              // inputFormatters: [
              //   if(digitsOnly) FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              //   if (isAmount) AmountTextFormatter()
              // ],
              cursorColor: AppColors.primaryColor,
              keyboardType: isAmount
                  ? const TextInputType.numberWithOptions(decimal: true)
                  : keyboardType,
              style: TextStyle(color: AppColors.primaryColor),
              inputFormatters: !digitsOnly
                  ? null
                  : [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
              decoration: InputDecoration(
                isDense: true,
                hintText: hintText,
                fillColor: !isEnabled ? AppColors.primaryColor.withOpacity(.03) : Colors.white.withOpacity(.1),
                // fillColor: Colors.white.withOpacity(.1),
                filled: true,
                suffixIcon: suffix,
                hintStyle: TextStyle(color: AppColors.primaryColor.withOpacity(.5)),
                border: textFieldBorder(),
                focusedBorder: textFieldBorder(true),
                enabledBorder: textFieldBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
