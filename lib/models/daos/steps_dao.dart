import 'package:application_vfm_new/models/entities/step.dart';
import 'package:floor/floor.dart';
import 'package:application_vfm_new/models/entities/distance.dart';

@dao //the following class defines a dao.
abstract class StepsDao {
  //Query #1: SELECT -> this allows to obtain all the entries of the distance table
  @Query('SELECT * FROM step')
  Future<List<Distance>> findAllDistances();

//trovo inizio
  @Query('SELECT * FROM Step ORDER BY dateTime ASC LIMIT 1')
  Future<Step?> findFirstDayInDb();

//trovo fine
  @Query('SELECT * FROM Step ORDER BY dateTime DESC LIMIT 1')
  Future<Step?> findLastDayInDb();



}