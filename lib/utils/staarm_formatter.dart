import 'package:intl/intl.dart';

class StaarmFormatter {
  static String formatPhone(String tel) {
    if (tel.length == 10) {
      return "${tel.substring(0, 3)} ${tel.substring(3, 6)} ${tel.substring(6)}";
    } else if (tel.length == 11) {
      return "${tel.substring(0, 4)} ${tel.substring(4, 7)} ${tel.substring(7)}";
    } else {
      tel = tel.padRight(13, "*");
      return "+${tel.substring(0, 3)} ${tel.substring(3, 6)} ${tel.substring(6, 9)} ${tel.substring(9)}";
    }
  }

  static String formatTripDate(DateTime date) {
    if (date == null) {
      return DateFormat('d MMM, h:mm a').format(DateTime.now());
    }
    return DateFormat('d MMM, h:mm a').format(date);
  }

  static String formatFromDateTime(DateTime date) {
    if (date == null) {
      return DateFormat('d MMM, y').format(DateTime.now());
    }
    return DateFormat('d MMM, y').format(date);
  }

  static String formatTimeFromDateTime(DateTime date) {
    if (date == null) {
      return DateFormat('h:mm a').format(DateTime.now());
    }
    return DateFormat('h:mm a').format(date);
  }

  static String formatTme(String date) {
    if (date == null || date.isEmpty) {
      return DateFormat('h:mm a').format(DateTime.now());
    }
    final datetime = DateTime.tryParse(date);
    if (datetime == null) {
      return DateFormat('h:mm a').format(DateTime.now());
    }
    return DateFormat('h:mm a').format(datetime);
  }

  static String formatDate(String date) {
    if (date == null || date.isEmpty) {
      return DateFormat.yMd().format(DateTime.now());
    }
    final datetime = DateTime.tryParse(date);
    if (datetime == null) {
      return DateFormat.yMd().format(DateTime.now());
    }
    return DateFormat.yMd().format(datetime);
  }

  static String formatDateShort(String date) {
    if (date == null || date.isEmpty) {
      return DateFormat('d MMM, y').format(DateTime.now());
    }
    final datetime = DateTime.tryParse(date);
    if (datetime == null) {
      return DateFormat('d MMM, y').format(DateTime.now());
    }
    return DateFormat('d MMM, y').format(datetime);
  }

  static String formatRewardsDate(String date) {
    if (date == null || date.isEmpty) {
      return DateFormat('d MMM').format(DateTime.now());
    }
    final datetime = DateTime.tryParse(date);
    if (datetime == null) {
      return DateFormat('d MMM').format(DateTime.now());
    }
    return DateFormat('d MMM').format(datetime);
  }

  static String formatDateTime(String date) {
    if (date == null || date.isEmpty) {
      return DateFormat('y/M/d H:mm:s').format(DateTime.now());
    }
    final datetime = DateTime.tryParse(date);
    if (datetime == null) {
      return DateFormat('y/M/d H:mm:s').format(DateTime.now());
    }
    return DateFormat('y/M/d H:mm:s').format(datetime);
  }

  static String formatDateMedium(String date) {
    if (date == null || date.isEmpty) {
      return DateFormat('d MMMM, y. H:mm:s').format(DateTime.now());
    }
    final datetime = DateTime.tryParse(date);
    if (datetime == null) {
      return DateFormat('d MMMM, y. H:mm:s').format(DateTime.now());
    }
    return DateFormat('d MMMM, y. H:mm:s').format(datetime);
  }

  static String formatDateForInvoicePayment(String date) {
    if (date == null || date.isEmpty) {
      return DateFormat('d MMM,  h:mm a').format(DateTime.now());
    }
    final datetime = DateTime.tryParse(date);
    if (datetime == null) {
      return DateFormat('d MMM, h:mm a').format(DateTime.now());
    }
    return DateFormat('d MMM, h:mm a').format(datetime);
  }

  static String formatFromString(String date) {
    if (date == null || date.isEmpty) {
      return DateFormat('d MMM, y').format(DateTime.now());
    }
    final datetime = DateTime.tryParse(date);
    if (datetime == null) {
      return DateFormat('d MMM, y').format(DateTime.now());
    }
    return DateFormat('d MMM, y').format(datetime);
  }

  static String formatDateLong(String date) {
    if (date == null || date.isEmpty) {
      return DateFormat.yMMMMEEEEd().format(DateTime.now());
    }
    final datetime = DateTime.tryParse(date);
    if (datetime == null) {
      return DateFormat.yMMMMEEEEd().format(DateTime.now());
    }
    return DateFormat.yMMMMEEEEd().format(datetime);
  }

  static String capitalise(String text) {
    if (text == null || text.length == 0) {
      return "";
    } else if (text.length == 1) {
      return text.toUpperCase();
    } else {
      final firstChar = text[0];
      return "${firstChar.toUpperCase()}${text.substring(1).toLowerCase()}";
    }
  }

  static String formatCurrencyInput(
    String amount, {
    bool displaySymbol = true,
    String from = '',
  }) {
      final formatter = NumberFormat.currency(
        locale: "en_NG",
        name: 'NGN',
        // symbol: displaySymbol ? "₦" : 'NGN',
        symbol: 'NGN ',
        decimalDigits: 0,
      );

      final amountDouble = double.tryParse(amount);
      if (amount == null || amountDouble == null) {
        return "";
      }

      return formatter.format(amountDouble);
  }
}
