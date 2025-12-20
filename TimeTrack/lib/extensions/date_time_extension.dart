extension DateTimeExtension on int {
  String get hhmm {
    final date = DateTime.fromMillisecondsSinceEpoch(this);
    final h = date.hour.toString().padLeft(2, '0');
    final m = date.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}
