import 'package:application_vfm_new/models/db.dart';
import 'package:application_vfm_new/models/entities/distance.dart';
import 'package:flutter/material.dart';

class DatabaseRepository extends ChangeNotifier {
  //The state of the database is just the AppDatabase
  final AppDatabase database;

  //Default constructor
  DatabaseRepository({required this.database});

  //This method wraps the findAllDistances() method of the DAO
  Future<List<distance>> findAllDistances() async {
    final results = await database.distances_dao.findAllDistances();
    return results;
  }

  //This method wraps the insertDistance() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> insertDistance(distance distances) async {
    await database.distances_dao.insertDistance(distances);
    notifyListeners();
  } //insertDistance

  //This method wraps the deleteDistance() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> removeDistance(distance distances) async {
    await database.distances_dao.deleteDistance(distances);
    notifyListeners();
  } //removeDistance
} //DatabaseRepository
