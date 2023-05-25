import 'package:floor/floor.dart';
import 'package:application_vfm_new/models/entities/distance.dart';

@dao //the following class defines a dao.
abstract class DistancesDao {
  //Query #1: SELECT -> this allows to obtain all the entries of the distance table
  @Query('SELECT * FROM distance')
  Future<List<Distance>> findAllDistances();

  //Query #2: INSERT -> this allows to add a distance in the table
  @insert
  Future<void> insertDistance(Distance distances);

  //Query #3: DELETE -> this allows to delete a distance from the table
  @delete
  Future<void> deleteDistance(Distance distances);
}
