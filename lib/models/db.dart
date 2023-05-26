import 'dart:async';
import 'package:application_vfm_new/models/daos/steps_dao.dart';
import 'package:application_vfm_new/models/entities/step.dart';
import 'package:application_vfm_new/models/typeConverts/dateTimeConvert.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'daos/distances_dao.dart';
import 'entities/distance.dart';

part 'db.g.dart';
@TypeConverters([DateTimeConverter])
@Database(version: 2, entities: [Step, Distance])
abstract class AppDatabase extends FloorDatabase {
  //Add all the daos as getters here
  DistancesDao get distancesDao;
  StepsDao get stepsDao;
}//AppDatabase