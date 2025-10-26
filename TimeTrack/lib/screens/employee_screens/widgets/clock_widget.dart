import 'dart:async';
import 'dart:ui';

class ClockWidget {
  late Timer _timer;

  Timer get timer => _timer;

  ClockWidget(){}

  String getCurrentTime() {
    DateTime now = DateTime.now();
    String hour = now.hour.toString().padLeft(2, '0');
    String minute = now.minute.toString().padLeft(2, '0');
    String second = now.second.toString().padLeft(2, '0');
    return '$hour:$minute:$second';
  }

  String getCurrentDate(){
    DateTime now = DateTime.now();
    String day = now.day.toString().padLeft(2, '0');
    String month = now.month.toString().padLeft(2, '0');
    String year = now.year.toString();
    return '$day/$month/$year';
  }

  void startTime(VoidCallback onTick){
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      onTick();
    });
  }
}
