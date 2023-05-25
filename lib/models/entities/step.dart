import 'package:floor/floor.dart';

@entity //per dire a floor che è una classe che definisce una entity
class Step {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final double value; //distanza percorsa in metri

  //final DateTime dateTime; //giorno in cui vengono percorsi

  Step(this.id, this.value);
}
