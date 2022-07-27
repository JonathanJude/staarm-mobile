/// AppButton types for verticalPadding, horizontalPadding, fontSizes etc.
enum AppButtonType {
  Tiny,
  Small,
  Medium,
  FulllWdith,
}

/// AppButton types for verticalPadding, horizontalPadding, fontSizes etc.
enum AppButtonIconPosition {
  leading,
  trailing,
}

/// A Utility class to help with `AppButton` & `AppOutlineButton` properties
class AppButtonHelpers {
  AppButtonHelpers._();

  // get button's vertical padding from type
  static double verticalPadding(AppButtonType type) {
    switch (type) {
      case AppButtonType.Tiny:
        return 6.0;
        break;
      case AppButtonType.Small:
        return 14.0;
        break;
      case AppButtonType.Medium:
        return 16.0;
        break;
      case AppButtonType.FulllWdith:
        return 18.0;
        break;
      default:
        return 14.0;
    }
  }

  // get button's horizontal padding from type
  static double horizontalPadding(AppButtonType type) {
    switch (type) {
      case AppButtonType.Tiny:
        return 18.0;
        break;
      case AppButtonType.Small:
        return 30.0;
        break;
      case AppButtonType.Medium:
        return 40.0;
        break;
      case AppButtonType.FulllWdith:
        return 40.0;
        break;
      default:
        return 30.0;
    }
  }

  // get button's text font size from type
  static double textFontSize(AppButtonType type) {
    switch (type) {
      case AppButtonType.Tiny:
        return 12.0;
        break;
      case AppButtonType.Small:
        return 14.0;
        break;
      case AppButtonType.Medium:
        return 16.0;
        break;
      case AppButtonType.FulllWdith:
        return 18.0;
        break;
      default:
        return 14.0;
    }
  }
}
