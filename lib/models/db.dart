import 'dart:async';

import 'package:application_vfm_new/models/daos/distances_dao.dart';
import 'package:application_vfm_new/models/daos/footsteps_dao.dart';
import 'package:application_vfm_new/models/entities/distance.dart';
import 'package:application_vfm_new/models/entities/footstep.dart';
import 'package:application_vfm_new/models/typeConverts/dateTimeConvert.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;


part 'db.g.dart';
@TypeConverters([DateTimeConverter])
@Database(version: 1, entities: [Distance, FootStep])
abstract class AppDatabase extends FloorDatabase {
  //Add all the daos as getters here
  DistancesDao get distancesDao;
  FootStepsDao get footstepsDao;
}//AppDatabase