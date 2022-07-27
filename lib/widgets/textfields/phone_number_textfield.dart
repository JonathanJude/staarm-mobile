import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../styles/colors.dart';

import '../app_vertical_divider.dart';

class PhoneNumberTextField extends StatelessWidget {
  final String Function(String) validator;
  final Function(String) onSave;
  final TextEditingController controller;
  final TextInputType textInputType;
  const PhoneNumberTextField({
    Key key,
    this.validator,
    this.onSave,
    this.controller,
    this.textInputType = TextInputType.phone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      padding: EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFFB2B2B2),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text(
            '+234',
            style: TextStyle(color: Colors.black),
          ),
          Icon(
            Icons.arrow_drop_down,
            color: Color(0xFF223345),
            size: 20,
          ),
          AppVerticalDivider(),
          Expanded(
            child: TextFormField(
              validator: validator,
              onSaved: onSave,
              keyboardType: textInputType,
              controller: controller,
              cursorColor: AppColors.mainBlack,
              maxLength: 11,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 5),
                isDense: true,
                labelText: 'Phone number',
                counterText: '',
                labelStyle: TextStyle(
                  color: Color(0xFF717171),
                  fontSize: 12,
                ),
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
