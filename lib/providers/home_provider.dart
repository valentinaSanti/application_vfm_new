import 'dart:math';

import 'package:flutter/material.dart';
import 'package:application_vfm_new/models/db.dart';

// this is the change notifier. it will manage all the logic of the home page: fetching the correct data from the database
// and on startup fetching the data from the online services
class HomeProvider extends ChangeNotifier {
  // data to be used by the UI
  late List<HR>
      heartRates; //quando chiamo Homeprovider.HR posso vedere i dati come output del provider

  // data fetched from external services or db
  late List<HR> _heartRatesDB;

  // selected day of data to be shown
  DateTime showDate = DateTime.now();

  // data generators faking external services. inizializzazioni
  final Random _random = Random();

  // constructor of provider which manages the fetching of all data from the servers and then notifies the ui to build
  HomeProvider() {
    //è l'inizializzazione, è la prima cosa che devo fare quando chiamo il provider //
    getDataOfDay(showDate);
    //aqi = _random.nextInt(100);
  }

  // method to select only the data of the chosen day
  void getDataOfDay(DateTime showDate) {
    this.showDate = showDate;
    heartRates = _heartRatesDB //uguale alla variabile privata
        .where((element) =>
            element.timestamp.day ==
            showDate
                .day) //looping in ogni elemento della lista HR, ordina e fa un filtro. looping in ogni elemento di HR della lista e fa chek che il dato si uguale a quello mostrato.
        .toList() //trasforma in una lista
        .reversed //ordine cronologico
        .toList(); //lista
    // after selecting all data we notify all consumers to rebuild
    notifyListeners(); //devo farlo se voglio che il mio stato cambi
  }
}
