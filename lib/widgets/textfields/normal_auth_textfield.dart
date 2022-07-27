import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../styles/colors.dart';

class NormalAuthTextField extends StatelessWidget {
  final String labelText;
  final Widget suffix;
  final bool obscureText;
  final String Function(String) validator;
  final Function(String) onSave;
  final Function(String) onChanged;
  final TextEditingController controller;
  final TextInputType textInputType;
  final int maxLines;
  final int maxLength;
  final List<TextInputFormatter> inputFormatters;
  const NormalAuthTextField({
    Key key,
    @required this.labelText,
    this.suffix,
    this.obscureText = false,
    this.validator,
    this.onSave,
    this.onChanged,
    this.controller,
    this.textInputType,
    this.maxLines,
    this.inputFormatters,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7),
      padding: EdgeInsets.only(
        top: 17,
        right: 12,
        left: 12,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFFB2B2B2),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              validator: validator,
              onSaved: onSave,
              keyboardType: textInputType,
              controller: controller,
              cursorColor: AppColors.mainBlack,
              onChanged: onChanged,
              maxLength: maxLength,
              obscureText: obscureText,
              maxLines: obscureText ? 1 : maxLines,
              inputFormatters: inputFormatters,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10),
                isDense: true,
                counterText: '',
                labelText: labelText ?? '',
                labelStyle: TextStyle(
                  color: Color(0xFF717171),
                  height: 0,
                  fontSize: 12,
                ),
                suffix: suffix,
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
