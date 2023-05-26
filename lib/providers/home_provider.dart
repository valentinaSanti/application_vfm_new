import 'dart:math';

import 'package:application_vfm_new/models/daos/steps_dao.dart';
import 'package:application_vfm_new/services/impact.dart';
import 'package:flutter/material.dart';
import 'package:application_vfm_new/models/entities/distance.dart';
import 'package:application_vfm_new/models/entities/step.dart' as prefix;
import 'package:application_vfm_new/models/db.dart';

// this is the change notifier. it will manage all the logic of the home page: fetching the correct data from the database
// and on startup fetching the data from the online services
class HomeProvider extends ChangeNotifier {
  late List<Step> step;
  late List<Distance> distance;
  final AppDatabase db;

  late List<Step> _step;
  late List<Distance> _distance;

  // data to be used by the UI
  //late List<Step>
  //    steps; //quando chiamo Homeprovider.HR posso vedere i dati come output del provider

  // selected day of data to be shown
  DateTime showDate = DateTime.now(). subtract(const Duration(days: 1));

  final ImpactService impactService;
  bool doneInit = false;

  // constructor of provider which manages the fetching of all data from the servers and then notifies the ui to build
  HomeProvider(this. impactService, this.db) {
    _init();
  }

  Future<void> _init() async {
    await getDataOfDay(showDate);
    doneInit = true;
    notifyListeners();
  }

  // method to select only the data of the chosen day
  Future<void> getDataOfDay(DateTime showDate) async {
    var firstDay = await db.distancesDao.findFirstDayInDb();
    var lastDay = await db.distancesDao.findLastDayInDb();
    if (showDate.isAfter(lastDay!.dateTime) ||
        showDate.isBefore(firstDay!.dateTime)) return;
        
    this.showDate = showDate;
    distance = await db.distancesDao.findDistancebyDate(
        DateUtils.dateOnly(showDate),//permette di fare operazioni sui dati
        DateTime(showDate.year, showDate.month, showDate.day, 23, 59));
    step = await db.stepsDao.findStepbyDate(DateUtils.dateOnly(showDate),
        DateTime(showDate.year, showDate.month, showDate.day, 23, 59));
    //lista
    // after selecting all data we notify all consumers to rebuild
    notifyListeners(); //devo farlo se voglio che il mio stato cambi
  }
}
