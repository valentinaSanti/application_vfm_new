import 'dart:ffi';

import 'package:application_vfm_new/models/entities/footstep.dart';
import 'package:floor/floor.dart';

@dao //the following class defines a dao.
abstract class FootStepsDao {
  //Query #1: SELECT -> this allows to obtain all the entries of the distance table
  @Query('SELECT * FROM FootStep')
  Future<List<FootStep>> findAllStep();

  @Query(
      'SELECT * FROM FootStep WHERE dateTime between :startTime and :endTime ORDER BY dateTime ASC')
  Future<List<FootStep>> findStepbyDate(DateTime startTime, DateTime endTime);

  //calcoliamo la somma dei passi del giorno selezionato
  @Query('SELECT SUM(value) FROM FootStep WHERE dateTime= :dataTime')
  Future<double?> sumFootStep(DateTime dataTime);

  //trovo inizio
  @Query('SELECT * FROM FootStep ORDER BY dateTime ASC LIMIT 1')
  Future<FootStep?> findFirstDayInDb();

  //trovo fine
  @Query('SELECT * FROM FootStep ORDER BY dateTime DESC LIMIT 1')
  Future<FootStep?> findLastDayInDb();

  //Query #2: INSERT -> this allows to add a distance in the table
  @insert
  Future<void> insertFootStep(FootStep footStep);

  //Query #3: DELETE -> this allows to delete a distance from the table
  @delete
  Future<void> deleteFootStep(FootStep footStep);
}
