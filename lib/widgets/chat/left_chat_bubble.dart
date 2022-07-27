import 'package:flutter/material.dart';

class LeftChatBubble extends StatelessWidget {
  final String message;

  const LeftChatBubble({
    Key key,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3, horizontal: 20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xffE1E3E6),
                ),
                borderRadius: BorderRadius.circular(12)
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
          Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}

class LeftChatBubbleWithImage extends StatelessWidget {
  final String message;
  final String imageUrl;

  const LeftChatBubbleWithImage({
    Key key,
    this.message,
    this.imageUrl,
  }) : super(key: key);

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
          Expanded(
            flex: 2,
            child: ClipPath(
              clipper: LeftChatBubbleClipper(),
              child: Container(
                color: Colors.purple[400],
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    FractionalTranslation(
                      translation: Offset(0.025, -0.04),
                      child: ClipRRect(
                        child: Image.network(
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
                          child: _message == null
                              ? SizedBox()
                              : Text(
                                  _message,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}

class LeftChatBubbleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    var factor = 10.0;
    path.moveTo(size.width - factor, 0);
    path.quadraticBezierTo(size.width, 0, size.width, factor);
    path.lineTo(size.width, size.height - factor);
    path.quadraticBezierTo(
        size.width, size.height, size.width - factor, size.height);
    path.lineTo(factor * 1.8, size.height);
    path.quadraticBezierTo(factor, size.height, factor, size.height - factor);
    path.lineTo(factor, factor);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
