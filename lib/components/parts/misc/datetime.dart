// Validate if 3-4 digits are correct time
bool timeValidator(String time) {
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

String dateSuffix(DateTime date) {
  var suffix = "th";
  var digit = date.day % 10;
  if ((digit > 0 && digit < 4) && (date.day < 11 || date.day > 13)) {
    suffix = ["st", "nd", "rd"][digit - 1];
  }
  return suffix;
}
