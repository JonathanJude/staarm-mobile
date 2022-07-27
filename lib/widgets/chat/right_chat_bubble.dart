import 'dart:io';

import 'package:flutter/material.dart';

class RightChatBubble extends StatelessWidget {
  final String message;
  final String time;

  const RightChatBubble({Key key, this.message, this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3, horizontal: 20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(child: Container()),
          Expanded(
            flex: 2,
            child: ClipPath(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xff824DFF).withOpacity(0.4),
                ),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        message,
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RightChatBubbleWithImage extends StatelessWidget {
  final String message;
  final String imageUrl;

  const RightChatBubbleWithImage({Key key, this.message, this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _message = message;
    if (message == null) {
      _message = "";
    }
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3, horizontal: 20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(child: SizedBox()),
          Expanded(
            flex: 2,
            child: ClipPath(
              clipper: RightChatBubbleClipper(),
              child: Container(
                color: Colors.red,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    FractionalTranslation(
                      translation: Offset(-0.025, -0.04),
                      child: ClipRRect(
                        child: imageUrl.contains("file:///")
                            ? Image.file(
                                File(imageUrl.replaceAll("file:///", "")),
                              )
                            : Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                              ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: _message.isEmpty
                              ? SizedBox()
                              : Text(
                                  _message,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RightChatBubbleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    var factor = 10.0;
    path.moveTo(0, factor);
    path.lineTo(0, size.height - factor);
    path.quadraticBezierTo(0, size.height, factor, size.height);
    path.lineTo(size.width - factor * 1.8, size.height);
    path.quadraticBezierTo(size.width - factor, size.height,
        size.width - factor, size.height - factor);
    path.lineTo(size.width - factor, factor);
    path.lineTo(size.width, 0);
    path.lineTo(factor, 0);
    path.quadraticBezierTo(0, 0, 0, factor);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
