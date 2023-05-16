import 'dart:math';
import 'package:intl/intl.dart';

class Steps {
  final DateTime time;
  final int value;

  Steps({required this.time, required this.value});

  Steps.fromJson(String date, Map<String, dynamic> json)
      : time = DateFormat('yyyy-MM-dd HH:mm:ss').parse('$date ${json["time"]}'),
        value = int.parse(json["value"]);

  @override
  String toString() {
    return 'Steps(time: $time, value: $value)';
  } //toString
} //Steps

class HR {
  // this class models the single heart rate data point
  final DateTime timestamp;
  final int value;

  HR({required this.timestamp, required this.value}); //constructure
}
