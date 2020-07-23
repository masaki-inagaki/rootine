// Validate if 3-4 digits are correct time
bool timeValidator(String time) {
  time = time.replaceAll(':', '');
  if (time.length == 3) {
    time = "0" + time;
  }
  if (time.length == 4 &&
      int.parse(time.substring(0, 2)) < 24 &&
      int.parse(time.substring(2, 4)) < 60) {
    return true;
  } else {
    return false;
  }
}

String timeFormatter(String time) {
  time = time.replaceAll(':', '');
  time = time.length == 3 ? "0" + time : time;
  return time.substring(0, 2) + ':' + time.substring(2, 4);
}

//return the suffix for the date (st, nd, rd)
String dateSuffix(DateTime date) {
  var suffix = "th";
  var digit = date.day % 10;
  if ((digit > 0 && digit < 4) && (date.day < 11 || date.day > 13)) {
    suffix = ["st", "nd", "rd"][digit - 1];
  }
  return suffix;
}

String intToDays(int day) {
  var suffix = ' day';
  if (day > 1) {
    suffix = suffix + "s";
  }
  return day.toString() + suffix;
}

String stringToTime(String time) {
  var stringTime = time.padLeft(4, "0");
  return stringTime.substring(0, 2) + ':' + stringTime.substring(2, 4);
}

String intToTime(int time) {
  var stringTime = time.toString().padLeft(4, "0");
  return stringToTime(stringTime);
}
