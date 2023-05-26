import 'package:floor/floor.dart';

@entity //per dire a floor che è una classe che definisce una entity
class Distance {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final double value; //distanza percorsa in metri

  final DateTime dateTime; //giorno in cui vengono percorsi

  Distance({this.id, required this.value,required this.dateTime});
}
