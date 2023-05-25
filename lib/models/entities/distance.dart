import 'package:floor/floor.dart';

@entity //per dire a floor che è una classe che definisce una entity
class distance {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final double value; //distanza percorsa in metri

  //final DateTime dateTime; //giorno in cui vengono percorsi

  distance(this.id, this.value);
}
