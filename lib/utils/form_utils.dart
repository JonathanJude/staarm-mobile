class FormUtils {
  FormUtils._();

  static bool isValidEmail(String email) {
    final emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);

    return emailValid;
  }

  static bool hasDigits(String text) {
    final hasDigits = text.contains(RegExp(r'[0-9]'));
    return hasDigits;
  }

  static bool hasUppercase(String text) {
    final hasUppercase = text.contains(RegExp(r'[A-Z]'));
    return hasUppercase;
  }

  static bool hasLowercase(String text) {
    final hasLowercase = text.contains(RegExp(r'[a-z]'));
    return hasLowercase;
  }

  static bool hasSpecialCharacters(String text) {
    final hasSpecialCharacters =
        text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    return hasSpecialCharacters;
  }

  static bool hasMinLength(String text, {int minLength = 8}) {
    final hasMinLength = text.length >= minLength;
    return hasMinLength;
  }
}
