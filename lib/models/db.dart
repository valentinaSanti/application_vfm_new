import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'daos/distances_dao.dart';
import 'entities/distance.dart';

part 'db.g.dart';

@Database(version: 1, entities: [Distance])
abstract class AppDatabase extends FloorDatabase {
  //Add all the daos as getters here
  DistancesDao get distances_dao;
}//AppDatabase