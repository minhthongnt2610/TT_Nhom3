import 'package:flutter/material.dart';

extension DateTimeExtension on int {
  String get hhmm {
    final date = DateTime.fromMillisecondsSinceEpoch(this);
    final h = date.hour.toString().padLeft(2, '0');
    final m = date.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}

extension TimeStringExtension on String {
  TimeOfDay toTimeOfDay() {
    final parts = split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }
}

extension TimeOfDayExtension on TimeOfDay {
  String toHHmm() {
    final h = hour.toString().padLeft(2, '0');
    final m = minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}
