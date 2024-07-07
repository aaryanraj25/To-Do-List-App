extension DateTimeExtensions on DateTime {
  String toFormattedString() {
    return "${this.year}-${this.month}-${this.day}";
  }
}
