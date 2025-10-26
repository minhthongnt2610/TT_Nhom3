import 'dart:async';

class ClockWidget {
  Timer _timer;

  Timer get timer => _timer;

  String getCurrentTime() {
    DateTime now = DateTime.now();
    String hour = now.hour.toString().padLeft(2, '0');
    String minute = now.minute.toString().padLeft(2, '0');
    String second = now.second.toString().padLeft(2, '0');
    return '$hour:$minute:$second';
  }
}
