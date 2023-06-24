import 'dart:math';

import 'package:application_vfm_new/models/daos/footsteps_dao.dart';
import 'package:application_vfm_new/services/impact.dart';
import 'package:flutter/material.dart';
import 'package:application_vfm_new/models/entities/distance.dart';
import 'package:application_vfm_new/models/entities/footstep.dart';
import 'package:application_vfm_new/models/db.dart';
import 'package:application_vfm_new/utils/shared_preferences.dart';

// this is the change notifier. it will manage all the logic of the home page: fetching the correct data from the database
// and on startup fetching the data from the online services
class HomeProvider extends ChangeNotifier {
  late List<FootStep> footstep;
  late List<Distance> distance;
  late double cfp;
  late double distanceTot;
  late  double footstepTot;
  final AppDatabase db;
  // data to be used by the UI

  late List<FootStep> _footstep;
  late List<Distance> _distance;

  // selected day of data to be shown
  DateTime showDate = DateTime.now().subtract(const Duration(days: 1));
  late DateTime lastFetch;

  final ImpactService impactService;
  bool doneInit = false;

  // constructor of provider which manages the fetching of all data from the servers and then notifies the ui to build
  HomeProvider(this.impactService, this.db) {
    _init();
  }

  Future<void> _init() async {
    await _fetchAndCalculate();
    await getDataOfDay(showDate);
    doneInit = true;
    notifyListeners();
  }

  Future<DateTime?> _getLastFetch() async {
    var data = await db.distancesDao.findAllDistances();
    if (data.isEmpty) {
      return null;
    }
    return data.last.dateTime;
    //guarda se ho già caricato
  }

  Future<void> _fetchAndCalculate() async {
    //prima inizializzo last fetch  se è nullo porto gli ultimi 2 giorni di dati
    lastFetch = await _getLastFetch() ??
        DateTime.now().subtract(const Duration(days: 2));
    // do nothing if already fetched
    if (lastFetch.day == DateTime.now().subtract(const Duration(days: 1)).day) {
      return; //evita di rifecciare i dati
    }
    _distance = await impactService.getDistanceOfDay(lastFetch);
    for (var element in _distance) {
      db.distancesDao.insertDistance(element);
    } // db add to the table
    _footstep = await impactService.getFootStepsOfDay(lastFetch);
    for (var element in _footstep) {
      db.footstepsDao.insertFootStep(element);
    } // db add to the table

    cfp = await sommaCFP(showDate);
    print('Hai evitato un impronta di carbonio di: $cfp [kgCO2e]');
    distanceTot = await distanceTOT(showDate);
  }

  Future<void> refresh() async {
    await _fetchAndCalculate();
    await getDataOfDay(showDate);
  }

  // method to select only the data of the chosen day
  Future<void> getDataOfDay(DateTime showDate) async {
    var firstDay = await db.distancesDao.findFirstDayInDb();
    print('$firstDay');
    var lastDay = await db.distancesDao.findLastDayInDb();
    print('$lastDay');
    if (showDate.isAfter(lastDay!.dateTime) ||
        showDate.isBefore(firstDay!.dateTime)) return;

    this.showDate = showDate;
    distance = await db.distancesDao.findDistancebyDate(
        DateUtils.dateOnly(showDate), //permette di fare operazioni sui dati
        DateTime(showDate.year, showDate.month, showDate.day, 23, 59));
    footstep = await db.footstepsDao.findStepbyDate(
        DateUtils.dateOnly(showDate),
        DateTime(showDate.year, showDate.month, showDate.day, 23, 59));
    //lista
    // after selecting all data we notify all consumers to rebuild
    //cfp = await sommaCFP(showDate);
    //_distanceTot = await distanceTOT(showDate);
    notifyListeners(); //devo farlo se voglio che il mio stato cambi
  }

  Future<double> distanceTOT(DateTime showDate) async {
    List<Distance> _distancetmp = await db.distancesDao.findAllDistances();
    List<double?> _distancevalue = await db.distancesDao.DataDistance(
        DateUtils.dateOnly(showDate),
        DateTime(showDate.year, showDate.month, showDate.day, 23, 59));
    double distanceTot = 0;
    if (_distancevalue.isNotEmpty) {
      for (var i in _distancevalue) {
        if (i != null) {
          distanceTot += i;
        }
      }
    }
    return distanceTot;
  }

  Future<double> sommaCFP(DateTime showDate) async {
    List<Distance> _distancetmp = await db.distancesDao.findAllDistances();
    List<double?> _distancevalue = await db.distancesDao.DataDistance(
        DateUtils.dateOnly(showDate),
        DateTime(showDate.year, showDate.month, showDate.day, 23, 59));
    double _distanceTot = 0;
    if (_distancevalue.isNotEmpty) {
      for (var i in _distancevalue) {
        if (i != null) {
          _distanceTot += i;
        }
      }
    }
    double value_miles = _distanceTot / 160900;

    cfp=0;
    cfp = (value_miles * 0.22143) ;
    //return _distanceTot; SERVIREBBE forse
    return cfp;
  }

  //***da decommentare una volta sistemata query Datafootstep***
  // Future<double> sommafootstep(DateTime showDate) async {
  //   List<FootStep> _footsteptmp = await db.footstepsDao.findAllStep();
  //   List<double?> _footstepvalue = await db.footstepsDao.Datafootstep(
  //       DateUtils.dateOnly(showDate),
  //       DateTime(showDate.year, showDate.month, showDate.day, 23, 59));
  //   double footstepTot = 0;
  //   if (_footstepvalue.isNotEmpty) {
  //     for (var i in _footstepvalue) {
  //       if (i != null) {
  //         footstepTot += i;
  //       }
  //     }
  //   }
    
  //   return footstepTot;
  // }
}
