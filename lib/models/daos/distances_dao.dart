import 'dart:ffi';

import 'package:floor/floor.dart';
import 'package:application_vfm_new/models/entities/distance.dart';

@dao //the following class defines a dao.
abstract class DistancesDao {
  //Query #1: SELECT -> this allows to obtain all the entries of the distance table
  @Query('SELECT * FROM Distance')
  Future<List<Distance>> findAllDistances();

  @Query(
      'SELECT * FROM Distance WHERE dateTime between :startTime and :endTime ORDER BY dateTime ASC')
  Future<List<Distance>> findDistancebyDate(
      DateTime startTime, DateTime endTime);

  //calcoliamo la somma dei passi del giorno selezionato
  @Query('SELECT SUM(value) FROM Distance WHERE dateTime= :dataTime')
  Future<double?> sumDistance(DateTime dataTime);

  //Query #2: INSERT -> this allows to add a distance in the table
  @insert
  Future<void> insertDistance(Distance distances);

  //Query #3: DELETE -> this allows to delete a distance from the table
  @delete
  Future<void> deleteDistance(Distance distances);

  //trovo inizio
  @Query('SELECT * FROM Distance ORDER BY dateTime ASC LIMIT 1')
  Future<Distance?> findFirstDayInDb();

//trovo fine
  @Query('SELECT * FROM Distance ORDER BY dateTime DESC LIMIT 1')
  Future<Distance?> findLastDayInDb();
}
