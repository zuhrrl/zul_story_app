class DateHelper {
  getDiffTimeInMinutes(
    date,
  ) {
    var now = DateTime.now();
    var selectedDate = DateTime.parse(date);
    return now.difference(selectedDate).inMinutes;
  }

  getDiffTimeInHours(
    date,
  ) {
    var now = DateTime.now();
    var selectedDate = DateTime.parse(date);
    return now.difference(selectedDate).inHours;
  }

  getDiffTimeInDays(
    date,
  ) {
    var now = DateTime.now();
    var selectedDate = DateTime.parse(date);
    return now.difference(selectedDate).inDays;
  }
}
