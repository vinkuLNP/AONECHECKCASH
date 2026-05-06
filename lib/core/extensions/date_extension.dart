extension DateFormatting on DateTime {
  String toFormattedDate() {
    return "$year-"
        "${month.toString().padLeft(2, '0')}-"
        "${day.toString().padLeft(2, '0')}";
  }
}
