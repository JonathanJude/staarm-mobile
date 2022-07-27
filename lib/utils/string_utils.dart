String zeroPrefixNumber(int number) => number < 10 ? "0$number" : "$number";


String formatDate(String date, [bool withTime = true]) {
  DateTime dateTime = DateTime.parse(date);
  formatDateTime(dateTime, withTime);
}

String formatDateTime(DateTime dateTime, [bool withTime = true]) {
  return "${zeroPrefixNumber(dateTime.day)} ${getMonth(dateTime.month, capitalized: true).substring(0, 3)} ${dateTime.year} ${withTime ? ", ${zeroPrefixNumber(dateTime.hour)}:${zeroPrefixNumber(dateTime.minute)}" : ""} ";
}
String getMonth(int monthNumber, {bool capitalized = false}) {
  String month;
  switch (monthNumber) {
    case 1:
      month = "january";
      break;
    case 2:
      month = "february";
      break;
    case 3:
      month = "march";
      break;
    case 4:
      month = "april";
      break;
    case 5:
      month = "may";
      break;
    case 6:
      month = "june";
      break;
    case 7:
      month = "july";
      break;
    case 8:
      month = "august";
      break;
    case 9:
      month = "september";
      break;
    case 10:
      month = "october";
      break;
    case 11:
      month = "november";
      break;
    case 12:
      month = "december";
      break;
  }
  if (capitalized) {
    return capitalize(month);
  }
  return month;
}

String capitalize(String it) => it.isEmpty
    ? it
    : it[0].toUpperCase() + it.substring(1, it.length).toLowerCase();
