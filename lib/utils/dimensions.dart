import 'package:flutter/widgets.dart'
    show
        BuildContext,
        MediaQuery,
        MediaQueryData,
        EdgeInsets,
        RenderBox,
        Offset;

class _AppDimension {
  MediaQueryData _queryData;
  _AppDimension(BuildContext context) {
    _queryData = MediaQuery.of(context);
  }

  double get topInset {
    return _queryData.padding.top;
  }

  double get width {
    return _queryData.size.width;
  }

  double get height {
    return _queryData.size.height;
  }

  double setHeight(double percentage) {
    if (percentage == 0) {
      return 0;
    }
    return height * (percentage / 100);
  }

  double setWidth(double percentage) {
    if (percentage == 0) {
      return 0;
    }
    return width * (percentage / 100);
  }
}

class _AppFontSizer {
  num _shortestSide;
  _AppFontSizer(BuildContext context) {
    _shortestSide = MediaQuery.of(context).size.shortestSide;
  }

  num sp(double percentage) {
    return ((_shortestSide) * (percentage / 1000)).ceil().toDouble();
  }
}

class _AppInsets {
  _AppDimension sizer;

  _AppInsets(BuildContext context) {
    sizer = _AppDimension(context);
  }

  EdgeInsets get zero {
    return EdgeInsets.zero;
  }

  EdgeInsets all(double inset) {
    return EdgeInsets.all(sizer.setWidth(inset));
  }

  EdgeInsets only({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) {
    return EdgeInsets.only(
      top: sizer.setHeight(top),
      left: sizer.setWidth(left),
      bottom: sizer.setHeight(bottom),
      right: sizer.setWidth(right),
    );
  }

  EdgeInsets fromLTRB(
    double left,
    double top,
    double right,
    double bottom,
  ) {
    return EdgeInsets.fromLTRB(
      sizer.setWidth(left),
      sizer.setHeight(top),
      sizer.setWidth(right),
      sizer.setHeight(bottom),
    );
  }

  EdgeInsets symmetric({
    double vertical = 0,
    double horizontal = 0,
  }) {
    return EdgeInsets.symmetric(
      vertical: sizer.setHeight(vertical),
      horizontal: sizer.setWidth(horizontal),
    );
  }
}

class AppScaleUtil {
  final BuildContext context;

  AppScaleUtil(this.context);

  _AppDimension get sizer => _AppDimension(context);
  _AppFontSizer get fontSizer => _AppFontSizer(context);
  _AppInsets get insets => _AppInsets(context);
}

Offset getPos(BuildContext context) {
  final RenderBox box = context.findRenderObject();
  return box.localToGlobal(Offset.zero);
}
