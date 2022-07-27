import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';

class AppPinInput extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onSubmit;
  final Function(String) onChanged;
  final int fieldsCount;
  // final BoxDecoration pinBoxDecoration;

  const AppPinInput({
    Key key,
    this.controller,
    this.focusNode,
    @required this.onSubmit,
    @required this.onChanged,
    this.fieldsCount = 4,
  }) : super(key: key);

  @override
  _AppPinInputState createState() => _AppPinInputState();
}

class _AppPinInputState extends State<AppPinInput> {

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
        border: Border.all(
            color: Color(0xFFB2B2B2) , width: 1),
        borderRadius: BorderRadius.circular(12.0),
      );
  }

  @override
  Widget build(BuildContext context) {
    return PinPut(
      fieldsAlignment: MainAxisAlignment.spaceBetween,
      fieldsCount: widget.fieldsCount,
      eachFieldWidth: 47,
      eachFieldHeight: 60,
      onSubmit: widget.onSubmit,
      keyboardType: TextInputType.number,
      focusNode: widget.focusNode,
      // obscureText: '●',
      onChanged: widget.onChanged,
      textStyle: TextStyle(
        color: Color(0xFF231F20),
        fontSize: 20,
      ),
      controller: widget.controller,
      submittedFieldDecoration: _pinPutDecoration,
      selectedFieldDecoration: _pinPutDecoration.copyWith(
        border: Border.all(color: Color(0xFFB2B2B2), width: 2),
      ),
      followingFieldDecoration: _pinPutDecoration.copyWith(
        border: Border.all(
          color: Color(0xFF231F20),
          width: 1,
        ),
      ),
    );
  }
}
