import 'package:application_vfm_new/models/entities/step.dart';
import 'package:floor/floor.dart';
import 'package:flutter/material.dart' as prefix;

@dao //the following class defines a dao.
abstract class StepsDao {
  //Query #1: SELECT -> this allows to obtain all the entries of the distance table
  @Query('SELECT * FROM Step')
  Future<List<Step>> findAllStep();

  @Query('SELECT * FROM Step WHERE dateTime between :startTime and :endTime ORDER BY dateTime ASC')
  Future<List<Step>> findStepbyDate(DateTime startTime, DateTime endTime);

//trovo inizio
  @Query('SELECT * FROM Step ORDER BY dateTime ASC LIMIT 1')
  Future<Step?> findFirstDayInDb();

//trovo fine
  @Query('SELECT * FROM Step ORDER BY dateTime DESC LIMIT 1')
  Future<Step?> findLastDayInDb();



}